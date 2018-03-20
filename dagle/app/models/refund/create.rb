class Refund
  Create =
    lambda do |attributes, user: nil|
      record = Refund.new(attributes)
      [record.save, record]
    end
end
