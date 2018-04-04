class APICode
  CODES = {
    success: [0, '成功'],
    # Global: 1xxx
    error: [1001, '出错了'],
    invalid_app_id: [1002, '错误的app_id'],
    invalid_timestamp: [1003, 'timestamp不正确'],
    invalid_signature: [1004, '错误的sn签名'],
    # User: 2xxx
    login_user_not_found: [2001, '用户不存在'],
    failed_to_send_sms_auth_code: [2002, '短信验证码发送失败'],
    sms_service_failed: [2003, '短信服务不可用'],
    invalid_sms_auth_code: [2004, '验证码不正确'],
    invalid_password: [2005, '密码错误'],
    register_user_found: [2006, '用户已存在'],
    register_invalid_mobile_phone: [2007, '手机号不正确'],
  }

  def self.get(name, message=nil)
    v = CODES[name.to_sym]
    if v
      { code: v[0], message: message || v[1], code_name: name.to_s }
    else
      { code: -1, message: message || '未知错误', code_name: 'unknown' }
    end
  end
end
