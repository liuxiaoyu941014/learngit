class MaterialCatalog
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialCatalog) ? record_or_id : MaterialCatalog.find(record_or_id)
      record.destroy
    end
end
