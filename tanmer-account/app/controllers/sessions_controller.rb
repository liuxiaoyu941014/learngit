require 'consts'
require 'des_encryptor'
class SessionsController < ThemeableController
  before_action :check_cookie_domain!
  include SessionsHelper
  include ApplicationHelper
  def new
    session[:return_to] = params[:return_to].presence
  end

  def create
    login_str = (params[:login] || '').strip
    condition =
      if login_str =~ /@/
        { email: login_str }
      elsif login_str =~ Consts::MOBILE_REGEXP
        { mobile_phone: login_str }
      else
        { username: login_str }
      end
    user = User.find_by(condition)
    result =
      if user.nil?
        APICode.get(:login_user_not_found)
      elsif !user.valid_password?(params[:password])
        APICode.get(:invalid_password)
      else
        user.sso_login!
        sign_in user
        APICode.get(:success)
      end
    render_api_json result
  end

  def destroy
    current_user.try(:sso_logout!)
    respond_to do |format|
      format.html { sign_out_and_redirect :user  }
      format.json { sign_out(:user); render :no_content }
    end
  end

  def status
    expires_now
    if signed_in?
      render_api_json APICode.get(:success).merge(data: {
        user: current_user.as_json(only: [:name, :image])
      })
    else
      head :no_content
    end
  end

  # This action is a example for Application Client
  # 这是一个其他外部App模块的后台代码，可以通过这个方式用token解密出用户信息
  # def create_with_token
  #   token = params[:token].presence
  #   if token
  #     begin
  #       data, _ = JWT.decode(token, Rails.application.secrets.app_secret, 'HS256')
  #       user_info = data['info'] #.slice('id', 'name', 'image', 'gender')
  #       # uid = DesEncryptor.decrypt(Rails.application.secrets.app_secret, data['uid'])
  #       Rails.logger.debug "login with token: #{user_info}"
  #       # user = User.create_with(user_info).find_or_create_by(uid: uid)
  #       # sign_in user
  #       render_api_json APICode.get(:success).merge(data: {
  #         return_to: session.delete(:return_to)
  #       })
  #     rescue => ex
  #       render_api_json APICode.get(:error, ex.message)
  #     end
  #   else
  #     head 404
  #   end
  # end

  # def get_token
  #   expires_now
  #   if app_from_header && signed_in?
  #     render_api_json APICode.get(:success).merge(data: {
  #       token: generate_jwt_token(app_from_header, current_user)
  #     })
  #   else
  #     head :no_content
  #   end
  # end

  private

  # def app_from_header
  #   appid = request.env['HTTP_X_LOGIN_APPID'].presence
  #   @app_from_header ||= appid && Doorkeeper::Application.find_by(uid: appid)
  # end

  def check_cookie_domain!
    parts = ENV['SSO_COOKIE_DOMAIN'].split('.').select{|s| s.present?}
    unless request.domain(parts.length - 1) == parts.join('.')
      render plain: "访问的域名不是#{parts.join('.')}"
    end
  end
end
