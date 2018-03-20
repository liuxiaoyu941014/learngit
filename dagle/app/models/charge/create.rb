class Charge
  Create =
    lambda do |attributes, user: nil|
      record = Charge.new(attributes)
      [record.save, record]
    end
end
