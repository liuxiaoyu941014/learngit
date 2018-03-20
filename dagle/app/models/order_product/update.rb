class OrderProduct
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(OrderProduct) ? record_or_id : OrderProduct.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
