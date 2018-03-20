class Community
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Community) ? record_or_id : Community.find(record_or_id)
      record.destroy
    end
end
