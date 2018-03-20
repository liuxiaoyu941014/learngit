# == Schema Information
#
# Table name: item_relations
#
#  master_id :integer
#  slave_id  :integer
#

class ItemRelation < ApplicationRecord
  belongs_to :master, class_name: 'Item'
  belongs_to :slave, class_name: 'Item'
  validates_presence_of :master, :slave
  validates_uniqueness_of :slave_id, scope: :master_id

  validate do |record|
    record.errors.add :slave, 'Slave contains master' if record.slave.has_deeper_child?(record.master.id)
  end
end
