# == Schema Information
#
# Table name: vendor_relations
#
#  id            :integer          not null, primary key
#  vendor_id     :integer
#  relation_type :string
#  relation_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class VendorRelation < ApplicationRecord
  audited

  belongs_to :vendor
  belongs_to :relation, polymorphic: true
end
