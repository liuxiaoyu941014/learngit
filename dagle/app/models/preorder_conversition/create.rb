class PreorderConversition
  Create =
    lambda do |attributes, user: nil|
      record = PreorderConversition.new(attributes)
      [record.save, record]
    end
end
