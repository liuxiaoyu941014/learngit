class MaterialStockAlert
  Create =
    lambda do |attributes, user: nil|
      record = MaterialStockAlert.new(attributes)
      [record.save, record]
    end
end
