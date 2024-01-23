require 'rails_helper'

describe 'POST /users/login' do
  let!(:user) { create(:user, role_cd: 1 ) }
  let!(:token) { JwtService.encode({ user_id: user.id }) }
  context 'when credentials are correct' do
    let(:valid_params) { { email: user.email, password: user.password } }

    it 'returns a token' do
      client = HttpClient.new(token)
      response = client.post('/api/v1/users/login', valid_params)

      expect(response.status).to equal(201)
      expect(JSON.parse(response.body)["token"]).not_to be_nil
    end
  end

  context 'when credentials are incorrect' do
    let(:invalid_params) { { email: 'user@example.com', password: 'wrongpassword' } }

    it 'returns an error' do
      client = HttpClient.new(token)
      response = client.post('/api/v1/users/login', invalid_params)
      expect(response.status).to equal(401)
      expect(JSON.parse(response.body)["error"]).to eq('Login invalid')
    end
  end
end