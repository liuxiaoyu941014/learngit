class MarketTemplate
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MarketTemplate) ? record_or_id : MarketTemplate.find(record_or_id)
      record.destroy
    end
end
