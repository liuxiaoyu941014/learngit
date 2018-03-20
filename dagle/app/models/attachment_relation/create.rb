class AttachmentRelation
  Create =
    lambda do |attributes, user: nil|
      record = AttachmentRelation.new(attributes)
      [record.save, record]
    end
end
