class Vendor
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Vendor) ? record_or_id : Vendor.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
