class AccountHistory
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(AccountHistory) ? record_or_id : AccountHistory.find(record_or_id)
      record.destroy
    end
end
