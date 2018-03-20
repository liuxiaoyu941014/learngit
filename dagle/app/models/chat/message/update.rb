class Chat::Message
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Chat::Message) ? record_or_id : Chat::Message.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
