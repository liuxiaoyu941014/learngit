class Forage::Source
  Create =
    lambda do |attributes, user: nil|
      record = Forage::Source.new(attributes)
      [record.save, record]
    end
end
