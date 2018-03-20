module AppAPI::V1
  class AppAuth < Grape::API

    resources :app_oauth do
      desc '微信登录' do
        success AppAPI::Entities::User
      end
      params do
        requires :code, type: String, desc: '微信APP返回的code'
        optional :device, type: String, desc: '设备信息，可以是UserAgent，也可以是自定义的名字。目的是让一个设备只生成一个access token'
      end
      get :wechat do
        url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code" % [
          Settings.weixin_open_app.app_id,
          Settings.weixin_open_app.app_secret,
          params[:code]
        ]
        response = Faraday.get(url)
        data = JSON.parse(response.body)
        error! data if data['errmsg']
        wx_user = ::User::Weixin.find_by("uid = ? OR unionid = ?", data['openid'], data['unionid'])
        if wx_user.nil?
          wx_user = ::User::Weixin.create!(uid: data['openid'], unionid: data['unionid'])
        end
        wx_user.access_token = data['access_token']
        wx_user.access_token_expired_at = data['expires_in'].seconds.since
        wx_user.refresh_token = data['refresh_token']
        wx_user.refresh_token_expired_at = 30.days.since
        wx_user.sync!
        unless wx_user.user
          wx_user.user = ::User.create!(headshot: wx_user.headshot, nickname: wx_user.name, password: SecureRandom.hex(5))
          wx_user.save!
        end
        present wx_user.user, with: AppAPI::Entities::User, access_token: wx_user.user.issue_api_token(params[:device]), type: :private
      end
    end
  end
end
