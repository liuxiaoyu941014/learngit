class OrderMaterial
  Create =
    lambda do |attributes, user: nil|
      record = OrderMaterial.new(attributes)
      [record.save, record]
    end
end
