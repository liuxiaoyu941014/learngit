class MaterialStockAlertDecorator < ApplicationDecorator
  def display_status
    if status == 'unprocessed'
      h.content_tag :span, style: 'color: red' do
        enum_l(object, :status)
      end
    else
      enum_l(object, :status)
    end
  end
  # def display_name
  #   h.content_tag :span, class: 'title' do
  #     name
  #   end
  # end

  # def created_at
  #   super.to_i
  # end

end
