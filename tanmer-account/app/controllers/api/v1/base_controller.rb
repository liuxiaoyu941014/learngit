require 'digest/md5'
require 'cgi'
class Api::V1::BaseController < ActionController::API
  before_action :doorkeeper_authorize!, unless: -> { request.cookies.key?(ENV['SSO_COOKIE_NAME']) }

  def current_user
    @current_user ||=
      if doorkeeper_token
        User.include_permissions.find(doorkeeper_token.resource_owner_id)
      else
        user = request.env['warden'].authenticate!(:scope => :user)
        if user
          @current_app = Doorkeeper::Application.find_by(uid: request.env['HTTP_X_LOGIN_APPID'])
        end
        user
      end
  end

  def current_app
    @current_app ||= doorkeeper_token.application
  end

  def signature_app
    @signature_app
  end

# 签名验证
  # *必要参数
  #   app_id => APP ID
  #   timestamp => 时间戳，与服务器时间相差不能超过10分钟
  #   sn => 签名
  # *签名方法
  #   URL参数按字母排序，值经过URL转码，连在一起，然后把密钥接在最后面，得到的字符串用MD5加密，如：
  #     app_id=e6be167d5c4c60564899f002926df6a0
  #     timestamp=1511845577
  #     blabla=ab&c
  #   参数排序之后是app_id, blabla, timestamp, 把值经过URL转码，连在一起，得到这个字符串
  #     app_id=e6be167d5c4c60564899f002926df6a0&blabla=ab%26c
  #   把密钥0cc175b9c0f1b6a831c399e269772661接到最后, 得到这个字符号串
  #     app_id=e6be167d5c4c60564899f002926df6a0&blabla=ab%26c0cc175b9c0f1b6a831c399e269772661
  #   经过MD5加密，得到这个字符串
  #     01b6ad520607a09b866d0f584dad5b30
  #   因此，最终发送请求的URL参数是这样的：
  #     app_id=e6be167d5c4c60564899f002926df6a0&timestamp=1511845577&blabla=ab%26c&sn=01b6ad520607a09b866d0f584dad5b30

# 上面是老签名模式，现在改为JWT模式
  def verify_signature!
    @signature_app = Doorkeeper::Application.find_by(uid: params[:app_id])
    unless @signature_app
      render json: APICode.get(:invalid_app_id)
      return
    end
    payload = (JWT.decode(params[:sn], @signature_app.secret, true, { :algorithm => 'HS256' }) rescue [{}]).first
    if payload.blank?
      render json: APICode.get(:invalid_signature)
      return
    end
    # timestamp = params[:timestamp].to_i
    # if (Time.now - timestamp).to_i.abs > 600 # 时间差超过10分钟就无效
    #   render json: APICode.get(:invalid_timestamp)
    #   return
    # end
    # sn = request.GET['sn']
    # str = request.GET.keys.sort.reduce("") do |s, k|
    #   k == 'sn' ? s :
    #     begin
    #       s = "#{s}&" unless s.empty?
    #       "#{s}#{k}=#{CGI.escape(params[k])}"
    #     end
    # end
    # str = "#{str}#{@signature_app.secret}"

    # if Digest::MD5.hexdigest(str) != sn
    #   render json: APICode.get(:invalid_signature)
    #   return
    # end
  end

  # 调试工具，方便生成带签名的URL
  def signature_for_app(app, params={})
    params = params.symbolize_keys
    params[:timestamp] = Time.now.to_i
    params[:app_id] = app.uid
    str = params.keys.sort.reduce("") do |s, k|
      s = "#{s}&" unless s.empty?
      "#{s}#{k}=#{CGI.escape(params[k].to_s)}"
    end
    params[:sn] = Digest::MD5.hexdigest("#{str}#{app.secret}")
    puts params.to_param
  end
end
