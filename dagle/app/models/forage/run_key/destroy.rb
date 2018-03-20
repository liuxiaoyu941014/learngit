class Forage::RunKey
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Forage::RunKey) ? record_or_id : Forage::RunKey.find(record_or_id)
      record.destroy
    end
end
