# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  symbol_name :string
#  name        :string
#  group_name  :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Permission < ApplicationRecord
  validates :symbol_name, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :roles, join_table: 'roles_permissions'
  has_and_belongs_to_many :users, join_table: 'users_permissions'
end
