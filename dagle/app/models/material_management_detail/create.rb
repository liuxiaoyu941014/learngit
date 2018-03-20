class MaterialManagementDetail
  Create =
    lambda do |attributes, user: nil|
      record = MaterialManagementDetail.new(attributes)
      [record.save, record]
    end
end
