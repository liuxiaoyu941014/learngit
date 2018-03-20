class Task
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Task) ? record_or_id : Task.find(record_or_id)
      record.destroy
    end
end
