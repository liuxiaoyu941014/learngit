class Vendor
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Vendor) ? record_or_id : Vendor.find(record_or_id)
      record.destroy
    end
end
