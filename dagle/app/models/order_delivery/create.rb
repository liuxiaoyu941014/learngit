class OrderDelivery
  Create =
    lambda do |attributes, user: nil|
      record = OrderDelivery.new(attributes)
      [record.save, record]
    end
end
