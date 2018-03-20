class FinanceBillDecorator < ApplicationDecorator
  # def display_name
  #   h.content_tag :span, class: 'title' do
  #     name
  #   end
  # end

  # def created_at
  #   super.to_i
  # end
  def display_status
    enum_l(object, :status)
  end
end
