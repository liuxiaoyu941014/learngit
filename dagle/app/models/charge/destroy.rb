class Charge
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Charge) ? record_or_id : Charge.find(record_or_id)
      record.destroy
    end
end
