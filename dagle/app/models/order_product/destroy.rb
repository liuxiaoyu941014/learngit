class OrderProduct
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(OrderProduct) ? record_or_id : OrderProduct.find(record_or_id)
      record.destroy
    end
end
