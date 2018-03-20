class UserCommunity
  Create =
    lambda do |attributes, user: nil|
      record = UserCommunity.new(attributes)
      [record.save, record]
    end
end
