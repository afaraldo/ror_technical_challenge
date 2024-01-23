require 'rails_helper'

describe 'GET /products/more_profit', type: :api do
  include Rack::Test::Methods # https://stackoverflow.com/questions/42848044/set-headers-before-each-request-in-rspec-request-spec/42848444#42848444

  let!(:user) { create(:user, role_cd: 1) }
  let!(:token) { JwtService.encode({ user_id: user.id }) }
  let!(:products) { create_list(:product, 3) }

  context 'with valid token' do
    it 'returns best selling products' do

      client = HttpClient.new(token)
      response = client.get('/api/v1/products/more_profit')

      expect(response.status).to equal(200)
    end
  end

  context 'with invalid token' do
    it 'returns an unauthorized error' do
      client = HttpClient.new("wrongtoken")
      response = client.get('/api/v1/products/more_profit')
      expect(response.status).to equal(401)
    end
  end
end
