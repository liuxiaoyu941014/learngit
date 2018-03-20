class ImportInformation
  Create =
    lambda do |attributes, user: nil|
      record = ImportInformation.new(attributes)
      [record.save, record]
    end
end
