# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  ordinal    :integer
#  roles      :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TaskType < ApplicationRecord
  audited
  has_many :task
  validates_presence_of :name
end
