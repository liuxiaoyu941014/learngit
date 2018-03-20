class Forage::Detail
  Create =
    lambda do |attributes, user: nil|
      record = Forage::Detail.new(attributes)
      [record.save, record]
    end
end
