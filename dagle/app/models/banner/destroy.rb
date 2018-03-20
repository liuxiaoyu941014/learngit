class Banner
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Banner) ? record_or_id : Banner.find(record_or_id)
      record.destroy
    end
end
