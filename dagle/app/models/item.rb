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

# 物件：抽象所有的物品，包含多个特征
class Item < ApplicationRecord
  store_accessor :features, :description
  cast_pinyin_for :name
  belongs_to :site
  belongs_to :catalog

  has_many :child_relations, class_name: 'ItemRelation', dependent: :destroy, foreign_key: :master_id
  has_many :parent_relations, class_name: 'ItemRelation', dependent: :destroy, foreign_key: :slave_id

  has_many :children, through: :child_relations, source: :slave
  has_many :parents, through: :parent_relations, source: :master

  validates_presence_of :name
  validates_presence_of :site
  validates_uniqueness_of :name, scope: :site_id

  def self.has_deeper_child?(record, child_id)
    record.children.each do |child|
      return true if child.id == child_id
    end
    record.children.each do |child|
      return true if has_deeper_child?(child, child_id)
    end
    false
  end

  def has_deeper_child?(child_id)
    self.class.has_deeper_child?(self, child_id)
  end
end
