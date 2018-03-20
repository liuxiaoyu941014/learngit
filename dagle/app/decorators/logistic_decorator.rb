class LogisticDecorator < ApplicationDecorator

  def display_status
    enum_l(object, :status)
  end

  # def created_at
  #   super.to_i
  # end

end
