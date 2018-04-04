require 'consts'
require 'des_encryptor'
module SessionsHelper

  def generate_jwt_token(app, user)
    payload = {
      uid: user.id,
      info: user.api_json(with_permissions: false),
      exp: 5.minutes.since.to_i
    }
    JWT.encode(payload, app.secret, 'HS256')
  end

  # 发送手机验证码
  def sms_auth_code_for(type)
    respond_to do |format|
      format.html { head 404 }
      format.json do
        user = params[:mobile].present? && User.find_by(mobile_phone: params[:mobile].strip)
        if type == :login && user.blank?
          render_api_json APICode.get(:login_user_not_found)
        elsif type == :register && user
          render_api_json APICode.get(:register_user_found)
        else
          if type == :register
            user = User.new(mobile_phone: params[:mobile].strip)
            user.validate
            if user.errors[:mobile_phone].any?
              return render_api_json APICode.get(:register_invalid_mobile_phone)
            end
          end
          is_dev = !(Rails.env.staging? || Rails.env.production?)
          code = is_dev ? ENV['SMS_DEV_AUTH_CODE'] : SecureRandom.random_number(10**ENV['SMS_AUTH_CODE_LENGTH'].to_i).to_s.rjust(ENV['SMS_AUTH_CODE_LENGTH'].to_i, '0')
          message = ENV['SMS_MOBILE_AUTH_TOKEN_TEMPLATE'].gsub('#code#', code)
          token = SmsService::Token.new(user.mobile_phone)
          token.create code: code, message: message
          begin
            if token.post
              render_api_json APICode.get(:success, "验证码发送成功！#{is_dev ? "非生产环境，虚拟验证码[#{code}]" : ''}")
            else
              render_api_json APICode.get(:failed_to_send_sms_auth_code)
            end
          rescue SmsService::Adapters::YunPian::SentFailed
            render_api_json APICode.get(:sms_service_failed)
          end
        end
      end
    end
  end
  def sms_auth_code_for_login
    sms_auth_code_for :login
  end
  def sms_auth_code_for_register
    sms_auth_code_for :register
  end

  # 手机+验证码登录
  def sms_auth_for(type)
    user = params[:mobile].present? && User.find_by(mobile_phone: params[:mobile].strip)
    if type == :login && user.blank?
      render_api_json APICode.get(:login_user_not_found)
    elsif type == :register && user
      render_api_json APICode.get(:register_user_found)
    else
      if type == :register
        user = User.new(mobile_phone: params[:mobile].strip)
      end
      t = SmsService::Token.new(user.mobile_phone)
      if t.match?(params[:code])
        if type == :register
          user.save!
        end
        user.sso_login!
        sign_in user
        render_api_json APICode.get(:success)
      else
        render_api_json APICode.get(:invalid_sms_auth_code)
      end
    end
  end
  def sms_auth_for_login
    sms_auth_for :login
  end
  def sms_auth_for_register
    sms_auth_for :register
  end
end
