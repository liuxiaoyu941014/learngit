class ImportInformation
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(ImportInformation) ? record_or_id : ImportInformation.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
