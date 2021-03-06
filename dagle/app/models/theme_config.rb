# == Schema Information
#
# Table name: theme_configs
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  theme_id   :integer
#  config     :text
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ThemeConfig < ApplicationRecord
  belongs_to :site
  belongs_to :theme

  validates_uniqueness_of :theme_id, scope: :site_id
end
