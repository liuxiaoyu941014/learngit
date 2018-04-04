class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :doorkeeper_authorize!
  # def with_token
  #   token = params[:token].presence
  #   api_key = token && ApiKey.find_by(auth_token: token)
  #   if api_key && api_key.user
  #     render json: api_key.user.as_json(only: [:uid, :name, :email, :image])
  #   else
  #     head :unauthorized
  #   end
  # end
  
  # HTTP Digest 验证，格式如下：
  #  Authorization: Basic `Base64.decode64("username:api_auth_token")`
  #  Authorization: Basic `Base64.decode64("email:api_auth_token")`
  #  Authorization: Basic `Base64.decode64("mobile:api_auth_token")`
  # 目前VPN验证在使用这个方法
  def http_digest
    http_auth = request.env['HTTP_AUTHORIZATION'] || ''
    base64_str = http_auth.split('Basic ', 2).last
    if base64_str
      identity, token = Base64.decode64(base64_str).split(':') rescue []
      if identity.present? && token.present?
        api_key = ApiKey.find_by(auth_token: token)
        if api_key && api_key.user && [api_key.user.email, api_key.user.username, api_key.user.mobile_phone].include?(identity)
          render json: api_key.user.as_json(only: [:uid, :name, :email, :image])
          return
        end
      end
    end
    head :unauthorized
  end
end
