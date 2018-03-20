class MemberCatalog
  Create =
    lambda do |attributes, user: nil|
      record = MemberCatalog.new(attributes)
      [record.save, record]
    end
end
