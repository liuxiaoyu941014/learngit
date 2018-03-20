# == Schema Information
#
# Table name: order_cvs
#
#  id           :integer          not null, primary key
#  cabinet_no   :string
#  cabinet_name :string
#  order_id     :integer
#  features     :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class OrderCv < ApplicationRecord
  audited
  store_accessor :features, :width, :height, :depth, :component_name, :component_length, :component_width, :component_depth, :material_name, :material_type, :code, :amount, :unit

  belongs_to :order
end
