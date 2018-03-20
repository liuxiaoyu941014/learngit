class MarketCatalog
  Create =
    lambda do |attributes, user: nil|
      record = MarketCatalog.new(attributes)
      [record.save, record]
    end
end
