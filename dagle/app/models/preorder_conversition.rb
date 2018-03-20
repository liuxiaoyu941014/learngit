# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  user_id    :integer
#  title      :string
#  content    :string
#  type       :string
#  features   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PreorderConversition < Ticket
  audited
  store_accessor :features, :offer, :member_id, :member_name, :member_phone, :member_address, :site_confirm, :factory_confirm
  validates_presence_of :site, :member_id
  has_many_comments
  # has_many :image_item_relations, as: :relation
  # has_many :image_items, :through => :image_item_relations
  # has_many :attachment_relations, as: :relation
  has_many :attachments, :through => :comments
  has_many :orders

  before_save do
    self.site_confirm = false if site_confirm.blank?
    self.factory_confirm = false if factory_confirm.blank?
  end

end
