# == Schema Information
#
# Table name: user_mobiles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :user_mobile, class: 'User::Mobile' do
    phone_number '15328077520'
  end
end
