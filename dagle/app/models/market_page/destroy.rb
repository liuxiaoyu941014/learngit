class MarketPage
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MarketPage) ? record_or_id : MarketPage.find(record_or_id)
      record.destroy
    end
end
