class Logistic
  Create =
    lambda do |attributes, user: nil|
      record = Logistic.new(attributes)
      [record.save, record]
    end
end
