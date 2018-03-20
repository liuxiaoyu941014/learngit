class Api::V1::Sessions::SmsController < Api::V1::BaseController
  ##
  # Send mobile auth code
  #
  # Post /api/v1/sessions/sms
  #
  # params:
  #   mobile  - require mobile number
  #
  # = Examples
  #
  #   resp = conn.post("/api/v1/sessions/sms", {"mobile" => '18687878787'})
  #   resp.body
  #   => {message: "验证码发送成功！#{is_dev && '非生成环境虚拟验证码[1234]'}", status: 'ok'}
  #
  #   resp = conn.post("/api/v1/sessions/sms", {"mobile" => 'aaaaaaaa'})
  #   resp.body
  #   => {message: '服务器出问题啦，请稍候在试！', status: 'error'}
  #   
  # 
  def create
    t = Sms::Token.new(params[:mobile])
    is_dev = !(Rails.env.staging? || Rails.env.production?)
    code = is_dev ? '1234' : (10000 + SecureRandom.random_number(10**8)).to_s[-5..-1]
    body = Settings.mobile.auth_token_template.gsub('#code#', code)
    t.create code: code, message: body
    begin
      response = t.post!
      response.valid!
      render json: {message: "验证码发送成功！#{is_dev ? '非生成环境虚拟验证码[1234]' : ''}", status: 'ok'}
    rescue Sms::Services::YunPianService::SentFailed
      render json: {message: '服务器出问题啦，请稍候在试！', status: 'error'}
    end
  end

end
