class ProductCatalog
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Catalog) ? record_or_id : ProductCatalog.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
