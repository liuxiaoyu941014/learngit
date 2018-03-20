class MaterialWarehouse
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialWarehouse) ? record_or_id : MaterialWarehouse.find(record_or_id)
      record.destroy
    end
end
