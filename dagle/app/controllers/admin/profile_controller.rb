class Admin::ProfileController < Admin::BaseController
  skip_after_action :verify_authorized
  def show
  end

  def connect_weixin
    conn = Faraday.new(:url => Settings.weixin_login.host)
    response = conn.get('/wx/mp_auth/%s/fetch_uid/%s' % [Settings.weixin_login.appid, params[:code]])
    data = JSON.parse(response.body)
    if data['uid']
      current_user.weixin = User::Weixin.find_or_create_by(uid: data['uid'])
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
