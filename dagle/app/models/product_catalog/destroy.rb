class ProductCatalog
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Catalog) ? record_or_id : ProductCatalog.find(record_or_id)
      record.destroy
    end
end
