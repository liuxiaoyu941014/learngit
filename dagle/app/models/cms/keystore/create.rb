class Cms::Keystore
  Create =
    lambda do |attributes, user: nil|
      record = Cms::Keystore.new(attributes)
      [record.save, record]
    end
end
