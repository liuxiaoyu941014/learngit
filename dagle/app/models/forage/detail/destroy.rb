class Forage::Detail
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Forage::Detail) ? record_or_id : Forage::Detail.find(record_or_id)
      record.destroy
    end
end
