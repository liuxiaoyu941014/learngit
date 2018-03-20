class ImportFailedInformation
  Create =
    lambda do |attributes, user: nil|
      record = ImportFailedInformation.new(attributes)
      [record.save, record]
    end
end
