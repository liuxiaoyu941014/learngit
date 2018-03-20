class User::WeixinDecorator < ApplicationDecorator

  def headshot
    super || 'user.svg'
  end

  def display_gender
    enum_l(object, :gender)
  end

  def created_at
    super.localtime.strftime('%Y-%m-%d %H:%M:%S')
  end

  def updated_at
    super.localtime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
