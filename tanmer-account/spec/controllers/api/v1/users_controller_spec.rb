require 'rails_helper'
RSpec.describe Api::V1::UsersController, :type => :controller do
  let(:user) { User.create!(email: 'user1@test.com', password: 'abcd1234defg', mobile_phone: '13900000000') }
  let(:dapp) { Doorkeeper::Application.create(name: 'a', redirect_uri: 'http://example.com') }
  describe "with valid token" do
    let(:token) do
      dapp.access_tokens.create(resource_owner_id: user.id)
    end
    before do
      allow(controller).to receive(:doorkeeper_token).and_return(token)
    end
    describe 'GET #profile' do
      it 'responds successfully with an HTTP 200 if token is valid' do
        get :profile
        expect(response).to have_http_status(200)
      end
      it 'responds user info' do
        get :profile
        j = JSON.parse(response.body)
        expect(j.keys).to match_array(["email", "image", "name", "permission_keys", "uid"])
      end
    end
  end
  describe "with invalid token" do
    describe 'GET #profile' do
      it 'responds with HTTP 401 if token is invalid' do
        get :profile
        expect(response).to have_http_status(401)
      end
    end
  end
end