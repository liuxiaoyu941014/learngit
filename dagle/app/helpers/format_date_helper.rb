module FormatDateHelper

  def format_date(date)
    date.strftime('%Y-%m-%d %H:%M:%S')
  end

end
