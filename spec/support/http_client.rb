class HttpClient
  include Rack::Test::Methods

  def initialize(token = nil)
    @token = token
  end

  def get(url, params = {}, headers = {})
    header 'Authorization', "Bearer #{@token}"
    super(url, params, headers)
  end

  def post(url, params = {}, headers = {})
    header 'Authorization', "Bearer #{@token}"
    super(url, params, headers)
  end

  private

  def app
    Rails.application
  end
end
