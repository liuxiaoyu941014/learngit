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

class User::Mobile < ApplicationRecord
  belongs_to :user
  validates :user, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, case_sensitive: false, mobile_phone: true
end
