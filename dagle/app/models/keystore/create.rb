class Keystore
  Create =
    lambda do |attributes, user: nil|
      record = Keystore.new(attributes)
      [record.save, record]
    end
end
