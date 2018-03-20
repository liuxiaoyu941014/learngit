class ImageItem
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(ImageItem) ? record_or_id : ImageItem.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
