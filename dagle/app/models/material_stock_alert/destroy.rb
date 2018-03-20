class MaterialStockAlert
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialStockAlert) ? record_or_id : MaterialStockAlert.find(record_or_id)
      record.destroy
    end
end
