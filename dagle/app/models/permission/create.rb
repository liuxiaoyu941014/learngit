class Permission
  Create =
    lambda do |attributes, user: nil|
      record = Permission.new(attributes)
      [record.save, record]
    end
end
