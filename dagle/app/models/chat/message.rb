class Chat::Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates_presence_of :text, :user_id, :room_id
end
