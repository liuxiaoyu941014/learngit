class MarketCatalog
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MarketCatalog) ? record_or_id : MarketCatalog.find(record_or_id)
      record.destroy
    end
end
