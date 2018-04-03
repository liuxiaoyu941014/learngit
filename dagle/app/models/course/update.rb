class Course
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Course) ? record_or_id : Course.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
