require 'grape-swagger'

module React
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api
    helpers do
      def current_user
        token = headers['Authorization']
        return nil if token.nil?

        payload = JwtService.decode(token.gsub!('Bearer ', ''))
        @current_user ||= User.find(payload['user_id']) if payload
      rescue
        nil
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    # Errors
    rescue_from :all do |e|
      Rails.logger.error "Rescued: #{e.class.name}: #{e.message}"

      error_response(message: e.message, status: 500)
    end

    resource :users do
      desc 'Login'
      params do
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end
      post :login do
        user = User.find_by_email(params[:email])

        if user && user.valid_password?(params[:password]) && user.admin?
          token = JwtService.encode({ user_id: user.id })
          { token: token }.to_json
        else
          error!('Login invalid', 401)
        end
      end
    end

    resource :products do
      before do
        authenticate!
      end
      desc 'Return products.', {
        headers: {
          "Authorization" => {
            "description" => "Valdates your identity",
            "required" => true
          }
        }
      }

      get "/best_sellers" do
        most_sold_products_per_category = Product
                                            .select("categories.name as category_name, products.name as product_name, COUNT(purchases.id) as purchases_count")
                                            .joins(:purchases)
                                            .joins(:categories)
                                            .group("categories.name, products.name")
                                            .order("categories.name, purchases_count DESC")
                                            .group_by(&:category_name)
                                            .map do |category_name, products|
          top_product = products.first
          {
            category: category_name,
            product: top_product.product_name,
            quantity: top_product.purchases_count
          }
        end
      end

      get "/more_profit" do
        most_profit_products_per_category = Product
                                            .select("categories.name as category_name, products.name as product_name, SUM(purchases.total) as purchases_total")
                                            .joins(:purchases)
                                            .joins(:categories)
                                            .group("categories.name, products.name")
                                            .order("categories.name, purchases_total DESC")
                                            .group_by(&:category_name)
                                            .map do |category_name, products|
          top_product = products.first
          {
            category: category_name,
            product: top_product.product_name,
            total: top_product.purchases_total
          }
        end
      end

      params do
        optional :from, type: Date
        optional :to, type: Date
        optional :category_id, type: Integer
        optional :client_id, type: Integer
        optional :admin_id, type: Integer
      end
      get "/" do
        declared_params = declared(params)

        query = Purchase.scoped

        if declared_params[:from] && declared_params[:to]
          query = query.where(created_at: declared_params[:from]..declared_params[:to])
        end

        query = query.joins(product: :categories).where('categories.id = ?', declared_params[:category_id]) if declared_params[:category_id]

        query = query.where(client_id: declared_params[:client_id]) if declared_params[:client_id]

        query = query.joins(product: :audits).where("audits.user_id = ? AND audits.user_type = 'User'", declared_params[:admin_id]) if declared_params[:admin_id]

        query.all
      end

      params do
        optional :from, type: DateTime
        optional :to, type: DateTime
        optional :category_id, type: Integer
        optional :client_id, type: Integer
        optional :admin_id, type: Integer
        requires :granularity, type: String, values: %w[hour day week year]
      end
      get "/summary" do
        declared_params = declared(params)

        query = Purchase.scoped

        if declared_params[:from] && declared_params[:to]
          query = query.where(created_at: declared_params[:from]..declared_params[:to])
        end

        query = query.joins(product: :categories).where('categories.id = ?', declared_params[:category_id]) if declared_params[:category_id]

        query = query.where(client_id: declared_params[:client_id]) if declared_params[:client_id]

        query = query.joins(product: :audits).where("audits.user_id = ? AND audits.user_type = 'User'", declared_params[:admin_id]) if declared_params[:admin_id]

        select_clause = "COUNT(*) as purchase_count"
        group_clause = ""

        if declared_params[:granularity]
          case declared_params[:granularity]
          when 'hour'
            group_clause = "to_char(purchases.created_at, 'YYYY-MM-DD HH24:00')"
          when 'day'
            group_clause = "to_char(purchases.created_at, 'YYYY-MM-DD')"
          when 'week'
            group_clause = "to_char(purchases.created_at, 'IYYY-IW')"
          when 'year'
            group_clause = "to_char(purchases.created_at, 'YYYY')"
          end

          select_clause = "COUNT(*) as purchase_count"
          query = query.select("#{group_clause} as formatted_date, #{select_clause}").group(group_clause)
        end

        query = query.select("#{group_clause}, #{select_clause}").group(group_clause) unless group_clause.empty?
        results = query.all

        results_hash = results.inject({}) do |hash, record|
          hash[record.formatted_date] = record.purchase_count
          hash
        end

        results_hash
      end

    end

    add_swagger_documentation \
      info: {
        title: "API Documentation --",
        description: "This API is build to be consumed from our mobile app.",
        contact_name: "Adrian Aguero",
        contact_email: "afaraldo.dev@gmail.com"
      },
      security_definitions: {
        jwt: {
          type: 'apiKey',
          name: 'Authorization',
          description: 'JWT Authorization header using the Bearer scheme. Example: "Authorization: Bearer {token}"'
        }
      },
      security: [
        { jwt: [] }
      ]
  end
end

