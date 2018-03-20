class Task
  Create =
    lambda do |attributes, user: nil|
      record = Task.new(attributes)
      [record.save, record]
    end
end
