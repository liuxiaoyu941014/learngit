class Staff
  Create =
    lambda do |attributes, user: nil|
      record = Staff.new(attributes)
      [record.save, record]
    end
end
