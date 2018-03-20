class FinanceHistory
  Create =
    lambda do |attributes, user: nil|
      record = FinanceHistory.new(attributes)
      [record.save, record]
    end
end
