class MaterialPurchase
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialPurchase) ? record_or_id : MaterialPurchase.find(record_or_id)
      record.destroy
    end
end
