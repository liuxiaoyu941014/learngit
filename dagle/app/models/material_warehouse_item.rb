# == Schema Information
#
# Table name: material_warehouse_items
#
#  id                    :integer          not null, primary key
#  material_warehouse_id :integer
#  material_id           :integer
#  stock                 :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class MaterialWarehouseItem < ApplicationRecord
  audited

  belongs_to :material
  belongs_to :material_warehouse

  # 库存变化时，更新物料总库存
  after_update -> { material.update_stock! }
end
