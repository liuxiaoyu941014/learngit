class Course
  Create =
    lambda do |attributes, user: nil|
      record = Course.new(attributes)
      [record.save, record]
    end
end
