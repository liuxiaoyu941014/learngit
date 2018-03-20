class ImportInformation
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(ImportInformation) ? record_or_id : ImportInformation.find(record_or_id)
      record.destroy
    end
end
