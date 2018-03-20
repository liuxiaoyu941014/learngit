# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  name       :string
#  features   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  name_py    :string
#  catalog_id :integer
#

class Delivery < Item
  audited
  store_accessor :features, :phone_number, :address
  validates_uniqueness_of :name
  validates_presence_of :name, :phone_number

  has_many :logistics

  # after_initialize do
  #   self.site_id = Site::MAIN_ID
  # end

  # before_validation do
  #   self.site_id = Site::MAIN_ID
  # end
end
