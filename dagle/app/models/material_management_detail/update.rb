class MaterialManagementDetail
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(MaterialManagementDetail) ? record_or_id : MaterialManagementDetail.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
