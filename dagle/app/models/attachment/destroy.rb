class Attachment
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Attachment) ? record_or_id : Attachment.find(record_or_id)
      record.destroy
    end
end
