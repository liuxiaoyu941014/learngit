class MaterialWarehouseItem
  Create =
    lambda do |attributes, user: nil|
      record = MaterialWarehouseItem.new(attributes)
      [record.save, record]
    end
end
