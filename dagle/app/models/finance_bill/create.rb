class FinanceBill
  Create =
    lambda do |attributes, user: nil|
      record = FinanceBill.new(attributes)
      [record.save, record]
    end
end
