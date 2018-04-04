# require 'rails_helper'
# RSpec.describe Api::V1::AuthController, :type => :controller do
#   let(:user) { User.create!(email: 'user1@test.com', password: 'abcd1234abc') }
#   describe "GET #with_token" do
#     it 'with invalid credential' do
#       post :with_token
#       expect(response).to have_http_status(401)
#     end
#     it 'with valid credential' do
#       key = user.api_keys.create!(name: 'Testing').reload
#       post :with_token, params: { token: key.auth_token }
#       expect(response).to have_http_status(200)
#     end
#   end
# end