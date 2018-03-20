class UserCommunity
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(UserCommunity) ? record_or_id : UserCommunity.find(record_or_id)
      record.destroy
    end
end
