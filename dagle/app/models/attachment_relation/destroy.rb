class AttachmentRelation
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(AttachmentRelation) ? record_or_id : AttachmentRelation.find(record_or_id)
      record.destroy
    end
end
