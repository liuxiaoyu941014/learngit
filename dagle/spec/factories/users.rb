# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nickname               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string
#

FactoryGirl.define do
  factory :user do
    nickname "User1"
    password "abcd1234"
    password_confirmation 'abcd1234'
    after :create do |user|
      create :user_mobile, user: user, phone_number: '13800000001'
    end
  end

  factory :super_admin, class: 'User' do
    nickname "SuperAdmin"
    password "abcd1234"
    password_confirmation 'abcd1234'
    after(:create) do |user|
      user.add_role(:super_admin)
      create :user_mobile, user: user, phone_number: '13900000001'
    end
  end

  factory :admin, class: 'User' do
    nickname "Admin"
    password "abcd1234"
    password_confirmation 'abcd1234'
    after(:create) do |user|
      user.add_role(:super_admin)
      create :user_mobile, user: user, phone_number: '13900000002'
    end
  end

  factory :agent, class: 'User' do
    nickname "Agent"
    password "abcd1234"
    password_confirmation 'abcd1234'
    after(:create) do |user|
      user.add_role(:super_admin)
      create :user_mobile, user: user, phone_number: '13900000003'
    end
  end
end
