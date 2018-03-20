class Forage::Simple
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Forage::Simple) ? record_or_id : Forage::Simple.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
