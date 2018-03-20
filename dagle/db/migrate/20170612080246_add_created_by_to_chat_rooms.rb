class AddCreatedByToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :created_by, :integer
  end
end
