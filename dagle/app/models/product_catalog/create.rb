class ProductCatalog
  Create =
    lambda do |attributes, user: nil|
      record = ProductCatalog.new(attributes)
      [record.save, record]
    end
end
