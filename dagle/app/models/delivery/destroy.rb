class Delivery
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Delivery) ? record_or_id : Delivery.find(record_or_id)
      record.destroy
    end
end
