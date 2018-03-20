class MemberDecorator < ApplicationDecorator

  def display_gender
    enum_l(object, :gender)
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
