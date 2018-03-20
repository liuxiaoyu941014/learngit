class MaterialWarehouse
  Create =
    lambda do |attributes, user: nil|
      record = MaterialWarehouse.new(attributes)
      [record.save, record]
    end
end
