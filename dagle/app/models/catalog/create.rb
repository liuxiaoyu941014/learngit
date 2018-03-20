class Catalog
  Create =
    lambda do |attributes, user: nil|
      record = Catalog.new(attributes)
      [record.save, record]
    end
end
