class ImageItemRelation
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(ImageItemRelation) ? record_or_id : ImageItemRelation.find(record_or_id)
      record.destroy
    end
end
