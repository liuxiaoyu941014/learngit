# == Schema Information
#
# Table name: catalogs
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  features   :jsonb
#

class Catalog < ApplicationRecord
  audited
  has_closure_tree dependent: :destroy
  store_accessor :features, :settings, :icon_url

  validates :name, uniqueness: {scope: [:parent_id, :type]}, presence: true
  before_validation :sanitize_settings

  private

  def sanitize_settings
    if settings.present?
      self.settings = settings.split(/[,，]/).map(&:strip) if settings.is_a?(String)
    else
      self.settings = []
    end
  end
end
