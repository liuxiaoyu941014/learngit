class MaterialManagementDecorator < ApplicationDecorator

  def display_operate_type
    enum_l(object, :operate_type)
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
