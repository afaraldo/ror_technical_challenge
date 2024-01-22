class ReportDailyToAdmins
  include Sidekiq::Worker

  def perform()
    # TEMPLATE VARIABLES
    # {{{subject}}}
    # {{{date}}}
    Rails.logger.info "--------------->>>>> ReportDailyToAdmins.call"
    template_id = "d-7e4d52e7e8f04055998555233d8a1b2b"
    date = Date.today

    purchases = ActiveRecord::Base.connection.execute(
      "SELECT products.name as product_name, COUNT(purchases.id) as quantity
       FROM purchases
       JOIN products ON products.id = purchases.product_id
       GROUP BY products.name"
    )

    products = purchases.map do |purchase|
      {
        "product_name" => purchase["product_name"],
        "quantity" => purchase["quantity"].to_i
      }
    end

    substitutions = {
      "subject" => "Informe Diario de Productos - #{date}",
      "date" => date,
      products: products
    }
    recipent = User.where(role_cd: 1).map {|user| { email: user.email} }


    ::EmailUtils.send(recipent, substitutions, template_id)
  end
end