class MemberNote
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MemberNote) ? record_or_id : MemberNote.find(record_or_id)
      record.destroy
    end
end
