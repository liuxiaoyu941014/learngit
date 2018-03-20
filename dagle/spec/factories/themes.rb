# == Schema Information
#
# Table name: themes
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  config       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :theme do
    id 1
    name "Theme1"
    display_name "MyString"
    config "MyText"

    factory :theme2 do
      id 2
      name "theme2"
      display_name "Theme2"
    end
  end
end
