class Cms::Keystore
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Cms::Keystore) ? record_or_id : Cms::Keystore.find(record_or_id)
      record.destroy
    end
end
