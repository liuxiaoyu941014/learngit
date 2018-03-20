class Order
  Update =
    lambda do |record_or_id, attributes, user: nil|
      attributes['price'] = attributes['price'].to_f * 100 if attributes['price'].present?
      record = record_or_id.is_a?(Order) ? record_or_id : Order.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
