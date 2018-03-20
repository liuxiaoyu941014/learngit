# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  site_id       :integer
#  title         :string
#  description   :text
#  creator_id    :integer
#  assignee_id   :integer
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ordinal       :integer
#  task_type_id  :integer
#  status        :integer
#

class Task < ApplicationRecord
  audited

  enum status: {
    processing: 0,  #处理中
    cancelled: 1,   #已取消
    completed: 2,   #已完成
    suspend: 3      #暂停生产任务
  }

  belongs_to :site
  belongs_to :task_type
  belongs_to :resource, polymorphic: true
  belongs_to :user, foreign_key: :assignee_id, class_name: 'User'
  validates_uniqueness_of :task_type_id, scope: [:resource_type, :resource_id]
  validates_presence_of :task_type_id, :site_id, :creator_id, :title

  after_initialize do
    self.status ||= 0
    self.site_id = Site::MAIN_ID
  end

  belongs_to :site
  belongs_to :resource, polymorphic: true

  before_validation do
    self.title = task_type.name if self.title.blank? && task_type
    self.ordinal = task_type.ordinal if self.ordinal.blank? && task_type
    self.site_id = Site::MAIN_ID
  end
end
