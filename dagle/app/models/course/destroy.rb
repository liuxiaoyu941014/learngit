class Course
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Course) ? record_or_id : Course.find(record_or_id)
      record.destroy
    end
end
