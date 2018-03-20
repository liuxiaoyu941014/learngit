class Complaint
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Complaint) ? record_or_id : Complaint.find(record_or_id)
      record.destroy
    end
end
