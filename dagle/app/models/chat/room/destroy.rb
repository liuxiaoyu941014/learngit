class Chat::Room
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Chat::Room) ? record_or_id : Chat::Room.find(record_or_id)
      record.destroy
    end
end
