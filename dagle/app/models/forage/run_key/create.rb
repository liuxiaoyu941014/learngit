class Forage::RunKey
  Create =
    lambda do |attributes, user: nil|
      record = Forage::RunKey.new(attributes)
      [record.save, record]
    end
end
