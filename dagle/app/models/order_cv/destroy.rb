class OrderCv
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(OrderCv) ? record_or_id : OrderCv.find(record_or_id)
      record.destroy
    end
end
