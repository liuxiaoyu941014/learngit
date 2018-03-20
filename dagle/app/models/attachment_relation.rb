# == Schema Information
#
# Table name: attachment_relations
#
#  id            :integer          not null, primary key
#  attachment_id :integer
#  relation_type :string
#  relation_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class AttachmentRelation < ApplicationRecord
  audited

  belongs_to :attachment
  belongs_to :relation, polymorphic: true
  validates_uniqueness_of :attachment_id, scope: [:relation_type, :relation_id]
end
