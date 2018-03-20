class Forage::DataCache
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Forage::DataCache) ? record_or_id : Forage::DataCache.find(record_or_id)
      record.destroy
    end
end
