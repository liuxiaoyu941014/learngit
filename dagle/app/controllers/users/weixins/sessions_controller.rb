class Users::Weixins::SessionsController < ApplicationController

  WEB_QR_TIMEOUT_SEC = 120

  def new
    respond_to do |format|
      format.json do
        token = generate_token
        timeout_sec = WEB_QR_TIMEOUT_SEC
        render json: {token: token, timeout_sec: timeout_sec}            
      end
      format.png do
        qrcode = RQRCode::QRCode.new(login_users_weixins_sessions_url(token: params[:token]))
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

  # 微信二维码扫码登录验证
  def login
    if session[:weixin_uid]
      user = User::Weixin.find_by_uid(session[:weixin_uid]).try(:user)
      sign_in user if user
    end

    unless current_user
      redirect_to user_wechat_omniauth_authorize_path(origin: request.original_url)
      return    
    end

    redis = Redis.current
    key = token_key(params[:token])
    @success = !!redis.get(key)
    if @success
      redis.set key, current_user.id
      redis.expire key, 30
    end
    
  end

  def status
    redis = Redis.current
    user_id = redis.get(token_key(params['token']))
    if user_id.nil?
      render json: { status: 'timeout' }
    elsif user_id == 'n/a'
      render json: { status: 'waiting' }
    else
      user = User.find_by(id: user_id)
      if user
        sign_in user
        render json: { status: 'ok', url: user.super_admin_or_admin? ? admin_root_path : root_path }
      else
        render json: { status: 'failed' }
      end
    end      
  end

  private
    def generate_token
      redis = Redis.current
      token = SecureRandom.uuid.remove('-')
      redis.set token_key(token), "n/a"
      redis.expire token_key(token), WEB_QR_TIMEOUT_SEC
      token
    end

    def token_key(token)
      token = "weixin-web-qr-login:#{token}"
    end

end