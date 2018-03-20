class ShoppingCart
  Create =
    lambda do |attributes, user: nil|
      record = ShoppingCart.new(attributes)
      [record.save, record]
    end
end
