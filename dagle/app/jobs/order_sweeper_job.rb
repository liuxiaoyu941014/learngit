class OrderSweeperJob
  include Sidekiq::Worker

  def perform
    if Settings.project.sxhop? || Settings.project.imolin? || Settings.project.meikemei?
      # 获取配置信息
      current_setting = AppSetting.current
      auto_deliver_seconds = (current_setting.auto_deliver_days.blank? ? 30 : current_setting.auto_deliver_days.to_i) * 24 * 60 * 60
      auto_cancel_seconds = (current_setting.auto_cancel_hours.blank? ? 1 : current_setting.auto_cancel_hours.to_f) * 60 * 60

      # 自动确认超过规定时间未收货的订单
      Order.delivering.each do |order|
        deliver_seconds = Time.now - order.updated_at
        next if auto_deliver_seconds > deliver_seconds
        OrderCompletedJob.new.perform(order.id)
      end

      # 自动关闭超过规定时间未支付的订单
      Order.where(status: ['open', 'pending']).each do |order|
        open_seconds = Time.now - order.updated_at
        next if auto_cancel_seconds > open_seconds
        order.cancelled!
      end
    end
  end
end
