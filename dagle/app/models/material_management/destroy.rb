class MaterialManagement
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialManagement) ? record_or_id : MaterialManagement.find(record_or_id)
      record.destroy
    end
end
