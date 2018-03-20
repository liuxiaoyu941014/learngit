class OrderNotificationJob
  include Sidekiq::Worker
  include  ActionView::Helpers::NumberHelper
  def perform(order_id)
    order = Order.find(order_id)
    case order.status
    when 'paid'
      if order.user && order.user.mobile
        msg = Settings.sms.templates.order_succeed_to_user.gsub('#site_name#', order.site.title).gsub('#phone#', order.site.available_phone || '无')
        body = OpenStruct.new(mobile_phone: order.user.mobile.phone_number, message: msg)
        response = Sms.service.(body)
        response.valid!
      end
      if order.site.user && order.site.user.mobile
        msg = Settings.sms.templates.order_succeed_to_agent.gsub('#price#', number_to_currency(order.price / 100.0, format: '%n 元'))
        body = OpenStruct.new(mobile_phone: order.site.user.mobile.phone_number, message: msg)
        response = Sms.service.(body)
        response.valid!
      end
    end
  end
end
