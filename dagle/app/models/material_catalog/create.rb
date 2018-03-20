class MaterialCatalog
  Create =
    lambda do |attributes, user: nil|
      record = MaterialCatalog.new(attributes)
      [record.save, record]
    end
end
