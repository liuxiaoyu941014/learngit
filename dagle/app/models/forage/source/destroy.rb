class Forage::Source
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Forage::Source) ? record_or_id : Forage::Source.find(record_or_id)
      record.destroy
    end
end
