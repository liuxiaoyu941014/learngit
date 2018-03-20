class Chat::Message
  Create =
    lambda do |attributes, user: nil|
      record = Chat::Message.new(attributes)
      [record.save, record]
    end
end
