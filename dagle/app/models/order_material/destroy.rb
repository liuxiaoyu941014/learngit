class OrderMaterial
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(OrderMaterial) ? record_or_id : OrderMaterial.find(record_or_id)
      record.destroy
    end
end
