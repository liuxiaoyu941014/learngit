module Frontend::OrdersHelper
  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
  def format_date(time)
    time.strftime("%Y.%m.%d")
  end
end
