class AttachmentRelation
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(AttachmentRelation) ? record_or_id : AttachmentRelation.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
