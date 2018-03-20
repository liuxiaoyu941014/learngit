class Member
  Create =
    lambda do |attributes, user: nil|
      record = Member.new(attributes)
      [record.save, record]
    end
end
