class UserDecorator < ApplicationDecorator

  def mobile_phone
    super || mobile.try(:phone_number)
  end

  def display_name
    nickname.presence || username.presence || email.presence || mobile.try(:phone_number)
  end

  def display_role
    roles.map(&:role_name).join(', ')
  end
end