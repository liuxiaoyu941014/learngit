class Forage::Detail
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Forage::Detail) ? record_or_id : Forage::Detail.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
