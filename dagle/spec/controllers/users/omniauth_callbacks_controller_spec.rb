require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:weixin] = OmniAuth::AuthHash.new({
      provider: 'weixin',
      uid: '123545',
      info: {
        nickname: "xiaohui",
        sex:  "male",
        province: 'Sichuan',
        city: 'Chengdu',
        headimgurl: 'http://xxx.headshot.img'
      },
      extra: {
        raw_info: {

        }
      }
    })
  end

  describe "GET #wechat" do
    it "returns http success"
  end

end
