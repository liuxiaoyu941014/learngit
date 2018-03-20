class MarketPage
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(MarketPage) ? record_or_id : MarketPage.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
