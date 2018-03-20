class Forage::DataCache
  Create =
    lambda do |attributes, user: nil|
      record = Forage::DataCache.new(attributes)
      [record.save, record]
    end
end
