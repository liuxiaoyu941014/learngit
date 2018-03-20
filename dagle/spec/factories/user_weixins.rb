# == Schema Information
#
# Table name: user_weixins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string
#  name       :string
#  headshot   :string
#  city       :string
#  province   :string
#  country    :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_weixin, class: 'User::Weixin' do
    
  end
end
