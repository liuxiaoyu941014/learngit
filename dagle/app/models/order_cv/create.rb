class OrderCv
  Create =
    lambda do |attributes, user: nil|
      record = OrderCv.new(attributes)
      [record.save, record]
    end
end
