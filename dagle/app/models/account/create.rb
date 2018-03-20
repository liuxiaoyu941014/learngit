class Account
  Create =
    lambda do |attributes, user: nil|
      record = Account.new(attributes)
      [record.save, record]
    end
end
