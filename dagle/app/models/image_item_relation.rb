# == Schema Information
#
# Table name: image_item_relations
#
#  id            :integer          not null, primary key
#  image_item_id :integer
#  relation_type :string
#  relation_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImageItemRelation < ApplicationRecord
  audited

  belongs_to :image_item
  belongs_to :relation, polymorphic: true
end
