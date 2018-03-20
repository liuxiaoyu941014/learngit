class ImageItem
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(ImageItem) ? record_or_id : ImageItem.find(record_or_id)
      record.destroy
    end
end
