class Forage::Simple
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Forage::Simple) ? record_or_id : Forage::Simple.find(record_or_id)
      record.destroy
    end
end
