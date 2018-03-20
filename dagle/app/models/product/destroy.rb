class Product
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Product) ? record_or_id : Product.find(record_or_id)
      [record.destroy, record]
    end
end
