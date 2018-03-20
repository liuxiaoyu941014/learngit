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

class Theme < ApplicationRecord
  has_many :theme_configs
  has_many :sites, through: :theme_configs

  validates_presence_of :name, :display_name
  validates_uniqueness_of :name, :display_name
end
