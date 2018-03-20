class Attachment
  Create =
    lambda do |attributes, user: nil|
      record = Attachment.new(attributes)
      [record.save, record]
    end
end
