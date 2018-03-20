class OrderCv
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(OrderCv) ? record_or_id : OrderCv.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
