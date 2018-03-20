class Produce
  Create =
    lambda do |attributes, user: nil|
      record = Produce.new(attributes)
      [record.save, record]
    end
end
