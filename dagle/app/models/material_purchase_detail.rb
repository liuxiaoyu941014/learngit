# == Schema Information
#
# Table name: material_purchase_details
#
#  id                   :integer          not null, primary key
#  material_id          :integer
#  material_purchase_id :integer
#  number               :integer
#  input_number         :integer          default(0)
#  price                :decimal(8, 2)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  features             :jsonb
#

class MaterialPurchaseDetail < ApplicationRecord
  belongs_to :material
  belongs_to :material_purchase
  audited associated_with: :material_purchase
  store_accessor :features, :order_code
  validates :number, presence: true
  validates_numericality_of :number, :greater_than_or_equal_to => 1
end
