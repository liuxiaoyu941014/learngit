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

class Ticket < ApplicationRecord
  belongs_to :site
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :site
  validates_presence_of :user
end
