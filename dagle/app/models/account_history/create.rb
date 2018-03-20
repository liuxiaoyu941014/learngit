class AccountHistory
  Create =
    lambda do |attributes, user: nil|
      record = AccountHistory.new(attributes)
      [record.save, record]
    end
end
