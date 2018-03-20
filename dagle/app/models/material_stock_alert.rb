# == Schema Information
#
# Table name: material_stock_alerts
#
#  id          :integer          not null, primary key
#  material_id :integer
#  title       :string
#  body        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MaterialStockAlert < ApplicationRecord
  audited

  enum status: [:unprocessed, :processed]

  belongs_to :material
end
