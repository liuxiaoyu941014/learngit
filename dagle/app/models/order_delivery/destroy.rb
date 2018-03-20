class OrderDelivery
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(OrderDelivery) ? record_or_id : OrderDelivery.find(record_or_id)
      record.destroy
    end
end
