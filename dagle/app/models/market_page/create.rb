class MarketPage
  Create =
    lambda do |attributes, user: nil|
      record = MarketPage.new(attributes)
      [record.save, record]
    end
end
