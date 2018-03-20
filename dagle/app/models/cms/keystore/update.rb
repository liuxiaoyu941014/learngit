class Cms::Keystore
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Cms::Keystore) ? record_or_id : Cms::Keystore.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
