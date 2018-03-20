class MaterialManagementDetail
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialManagementDetail) ? record_or_id : MaterialManagementDetail.find(record_or_id)
      record.destroy
    end
end
