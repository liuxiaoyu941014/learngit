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

class MaterialWarehouse < Item
  audited
  store_accessor :features, :warehouse_user, :phone, :warehouse_address
  has_many :material_warehouse_items, dependent: :destroy
  has_many :materials, through: :material_warehouse_items

  # 仓库只属于本公司，不能设置为其他Site
  after_initialize do
    self.site_id = Site::MAIN_ID
  end

  before_validation do
    self.site_id = Site::MAIN_ID
  end
end
