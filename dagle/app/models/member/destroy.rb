class Member
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Member) ? record_or_id : Member.find(record_or_id)
      record.destroy
    end
end
