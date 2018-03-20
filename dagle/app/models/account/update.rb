class Account
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Account) ? record_or_id : Account.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
