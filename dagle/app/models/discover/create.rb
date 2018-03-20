class Discover
  Create =
    lambda do |attributes, user: nil|
      record = Discover.new(attributes)
      [record.save, record]
    end
end
