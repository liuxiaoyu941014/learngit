class Delivery
  Create =
    lambda do |attributes, user: nil|
      record = Delivery.new(attributes)
      [record.save, record]
    end
end
