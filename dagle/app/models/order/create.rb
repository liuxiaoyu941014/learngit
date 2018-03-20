class Order
  Create =
    lambda do |attributes, user: nil|
      attributes['price'] = attributes['price'].to_f * 100
      record = Order.new(attributes)
      [record.save, record]
    end
end
