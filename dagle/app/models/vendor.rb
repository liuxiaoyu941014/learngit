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

class Vendor < Item
  store_accessor :features, :contact_name, :phone_number
  has_many :vendor_relations
  audited

  # 供应商只能够属于公司
  after_initialize do  #该after_initialize每当一个Active Record对象被实例化回调将被调用
    self.site_id = Site::MAIN_ID
  end

  before_validation do   
    self.site_id = Site::MAIN_ID
  end
end
