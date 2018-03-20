class Account
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Account) ? record_or_id : Account.find(record_or_id)
      record.destroy
    end
end
