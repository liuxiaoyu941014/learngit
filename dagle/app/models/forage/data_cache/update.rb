class Forage::DataCache
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Forage::DataCache) ? record_or_id : Forage::DataCache.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
