class Vendor
  Create =
    lambda do |attributes, user: nil|
      record = Vendor.new(attributes)
      [record.save, record]
    end
end
