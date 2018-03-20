class Chat::Room
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Chat::Room) ? record_or_id : Chat::Room.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
