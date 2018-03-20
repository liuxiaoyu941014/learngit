class Product
  Create =
    lambda do |attributes, user: nil|
      record = Product.new(attributes)
      [record.save, record]
    end
end
