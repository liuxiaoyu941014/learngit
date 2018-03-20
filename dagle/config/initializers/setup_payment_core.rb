PaymentCore.setup do |p|
  p.api_key = Settings.payment.api_key # 必选
  p.app_id = Settings.payment.api_id # 选填
  p.default_subject = '快捷支付' # 选填
  p.default_body = '快捷支付' # 选填
  p.default_channels = Settings.payment.channels # 开启的支付通道
  p.default_success_url = '' # 默认支付成功的URL，选填
  p.enable_pingpp_one = Settings.payment.enable_pingpp_one # 是否开启壹支付
  p.before_create_charge = ->(options) { options } # 创建Charge凭据之前调用，可用作验证网页传来的参数
  p.after_create_charge = ->(options) {} # 创建Charge凭据之后调用，可用作纪录生产的凭据
  # 配置支付成功之后的回调，如下面例子：
  p.on_charge_succeeded = lambda do |json|
    order = Order.find_by(code: json[:order_no])
    if order
      order.build_charge(
        pingpp_charge_id: json[:id],
        client_ip: json[:client_ip],
        channel: json[:channel],
        time_created: json[:created],
        time_paid: json[:time_paid],
        transaction_no: json[:transaction_no]
      )
      order.status = 'paid'
      order.save!
    end
  end

  # 配置退款成功之后的回调，如下面例子：
  p.on_refund_succeeded = lambda do |json|
    order = Order.find_by(code: json[:charge_order_no])
    if order
      order.build_refund(
        pingpp_charge_id: json[:charge],
        event_id: json[:id],
        order_no: json[:order_no],
        description: json[:description],
        charge: json[:charge],
        amount: json[:amount],
        created: json[:created],
        charge_order_no: json[:charge_order_no],
        succeed: json[:succeed],
        status: json[:status],
        time_succeed: json[:time_succeed],
        failure_code: json[:failure_code],
        failure_msg: json[:failure_msg]
      )
      order.refund_status = 'refunded'
      order.status = 'cancelled'
      order.save
    end
  end

  # 配置微信，为了获取openid
  p.weixin.app_id = Settings.weixin.app_id
  p.weixin.app_secret = Settings.weixin.app_secret
end
