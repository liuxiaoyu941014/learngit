class TaskType
  Create =
    lambda do |attributes, user: nil|
      record = TaskType.new(attributes)
      [record.save, record]
    end
end
