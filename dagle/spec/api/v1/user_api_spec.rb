require 'rails_helper'
RSpec.describe "resources: /v1/users", type: :api do
  describe 'signup' do
    it 'with mobile phone only' do
      post '/v1/users',
        params: {
          mobile_phone: '15328077520', mobile_phone_code: '112233'
        }
      expect(response.status).to eq(201)
      json = JSON.parse(response.body)
      expect(json['mobile_phone']).to eq('15328077520')
    end

    it 'with extra params' do
      post '/v1/users',
        params: {
          mobile_phone: '15328077520', mobile_phone_code: '112233', device: 'Rspec Test', nickname: 'xiaohui'
        }
      expect(response.status).to eq(201)
      json = JSON.parse(response.body)
      expect(json['mobile_phone']).to eq('15328077520')
      expect(json['nickname']).to eq('xiaohui')
    end

    it 'missing mobile_phone' do
      post '/v1/users'
      expect(response.status).to eq(400)
    end
  end

  describe 'signin' do
    it 'with valid credential' do
      _, user = ::User::Create.(mobile_phone: '15328077520', password: 'abcd1234')
      post '/v1/users/auth',
        params: {
          mobile_phone: user.mobile_phone, password: 'abcd1234'
        }
      expect(response.status).to eq(201)
      json = JSON.parse(response.body)
      expect(json['access_token']).to_not be_nil
      expect(json['access_token'].length).to eq(40)
    end

    it 'with invalid credential' do
      _, user = ::User::Create.(mobile_phone: '15328077520', password: 'abcd1234')
      post '/v1/users/auth',
        params: {
          mobile_phone: user.mobile_phone, password: 'wrong'
        }
      expect(response.status).to eq(404)
    end
  end

  it 'get my info' do
    _, user = ::User::Create.(mobile_phone: '15328077520', password: 'abcd1234')
    api_token = user.api_tokens.create
    get '/v1/users/me', headers: { 'Authorization' => "Bearer #{api_token.token}" }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json['mobile_phone']).to eq(user.mobile_phone)
  end
end
