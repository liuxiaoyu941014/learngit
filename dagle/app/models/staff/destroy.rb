class Staff
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Staff) ? record_or_id : Staff.find(record_or_id)
      record.destroy
    end
end
