class TaskType
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(TaskType) ? record_or_id : TaskType.find(record_or_id)
      record.destroy
    end
end
