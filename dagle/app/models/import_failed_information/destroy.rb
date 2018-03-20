class ImportFailedInformation
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(ImportFailedInformation) ? record_or_id : ImportFailedInformation.find(record_or_id)
      record.destroy
    end
end
