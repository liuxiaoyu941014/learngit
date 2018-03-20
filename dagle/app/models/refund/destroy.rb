class Refund
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Refund) ? record_or_id : Refund.find(record_or_id)
      record.destroy
    end
end
