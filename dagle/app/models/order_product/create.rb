class OrderProduct
  Create =
    lambda do |attributes, user: nil|
      record = OrderProduct.new(attributes)
      [record.save, record]
    end
end
