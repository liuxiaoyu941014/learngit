class MemberNote
  Create =
    lambda do |attributes, user: nil|
      record = MemberNote.new(attributes)
      [record.save, record]
    end
end
