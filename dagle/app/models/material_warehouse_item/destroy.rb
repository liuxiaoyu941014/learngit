class MaterialWarehouseItem
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialWarehouseItem) ? record_or_id : MaterialWarehouseItem.find(record_or_id)
      record.destroy
    end
end
