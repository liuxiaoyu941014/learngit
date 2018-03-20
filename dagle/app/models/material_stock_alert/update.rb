class MaterialStockAlert
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(MaterialStockAlert) ? record_or_id : MaterialStockAlert.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
