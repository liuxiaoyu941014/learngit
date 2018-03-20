class Users::Weixins::ConnectsController < ApplicationController
  WEB_QR_TIMEOUT_SEC = 120


  def new
    respond_to do |format|
      format.json do
        token = generate_token
        timeout_sec = WEB_QR_TIMEOUT_SEC
        render json: {token: token, timeout_sec: timeout_sec}          
      end
      format.png do
        qrcode = RQRCode::QRCode.new(confirm_users_weixins_connects_url(token: params['token']))
        send_data qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 240,
          border_modules: 4,
          module_px_size: 6,
          file: nil
        )
      end
    end
  end


  def confirm
    @token = params['token']
    @confirmed = false
    if session["weixin_uid"]
      @weixin_user = User::Weixin.find_by_uid(session["weixin_uid"])
      redis = Redis.current
      key = token_key(params['token'])
      token_value = redis.get(key)
      # 获取绑定用户ID
      if token_value && token_value =~ /user-\d+/
        user_id = token_value.split('-').last
        @bind_user = User.find_by_id(user_id)
        if @bind_user.id == @weixin_user.user.try(:id)
          redis.set key, session["weixin_uid"]
          @confirmed = true
        end
      end
    else
      redirect_to user_wechat_omniauth_authorize_url(origin: request.original_url)
    end
  end

  def create
    redis = Redis.current
    token = get_token
    key = token_key(token)
    @success = !!redis.get(key)
    if @success
      redis.set key, session["weixin_uid"]
      session["weixin_uid"] = nil
    end
  end

  def status
    status = ''
    redis = Redis.current
    key = token_key(params['token'])
    token_value = redis.get(key)
    if token_value =~ /user-\d+/
      status = 'waiting'
    elsif token_value.nil?
      status = 'timeout'
    else
      weixin_user = User::Weixin.find_by_uid(token_value)
      if weixin_user.user
        status = 'used'
      else
        weixin_user.user = current_user
        if weixin_user.save
          status = 'success'
        else
          status = 'fail'
        end
      end
    end
    render json: {status: status}
  end

  private
  def generate_token
    redis = Redis.current
    token = SecureRandom.uuid.remove('-')
    redis.set token_key(token), "user-#{current_user.id}"
    redis.expire token_key(token), WEB_QR_TIMEOUT_SEC
    token
  end

  def token_key(token)
    token = "weixin-web-qr-connect:#{token}"
  end

end