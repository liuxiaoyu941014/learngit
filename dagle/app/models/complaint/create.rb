class Complaint
  Create =
    lambda do |attributes, user: nil|
      record = Complaint.new(attributes)
      [record.save, record]
    end
end
