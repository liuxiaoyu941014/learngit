class Chat::Room
  Create =
    lambda do |attributes, user: nil|
      record = Chat::Room.new(attributes)
      [record.save, record]
    end
end
