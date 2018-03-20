class MarketTemplate
  Create =
    lambda do |attributes, user: nil|
      record = MarketTemplate.new(attributes)
      [record.save, record]
    end
end
