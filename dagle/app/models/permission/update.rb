class Permission
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Permission) ? record_or_id : Permission.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
