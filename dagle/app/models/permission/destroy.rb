class Permission
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Permission) ? record_or_id : Permission.find(record_or_id)
      record.destroy
    end
end
