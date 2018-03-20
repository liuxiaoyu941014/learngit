class AddOwnerToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :chat_rooms, :owner, polymorphic: true, index: true
  end
end
