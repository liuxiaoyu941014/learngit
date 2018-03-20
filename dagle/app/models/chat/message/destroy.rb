class Chat::Message
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Chat::Message) ? record_or_id : Chat::Message.find(record_or_id)
      record.destroy
    end
end
