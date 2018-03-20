class OrderCompletedJob
  include Sidekiq::Worker

  def perform(order_id, from='auto')
    order = Order.find_by(id: order_id)
    if order
      if order.delivering? && from == 'auto'
        order.completed!
        send_sms(order, from)
      elsif order.completed? && from != 'auto'
        send_sms(order, from)
      end
    end
  end

  def send_sms(order, from)
    if order.user && order.user.mobile
      msg = Settings.sms.templates.order_completed_to_user.gsub('#order_code#', order.code).gsub('#from#', from == 'auto' ? '自动' : from)
      body = OpenStruct.new(mobile_phone: order.user.mobile.phone_number, message: msg)
      response = Sms.service.(body)
      response.valid!
    end
  end
end
