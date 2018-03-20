# == Schema Information
#
# Table name: order_products
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  product_id :integer
#  amount     :integer
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderProduct < ApplicationRecord
  audited
  belongs_to :order
  belongs_to :product
  validates_presence_of :order, :amount
  validates_uniqueness_of :product_id, scope: :order_id

  before_create :set_default_price

  private

  def set_default_price
    self.price ||= product.price * amount
  end
end
