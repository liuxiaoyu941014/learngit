class Forage::Simple
  Create =
    lambda do |attributes, user: nil|
      record = Forage::Simple.new(attributes)
      [record.save, record]
    end
end
