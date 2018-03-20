class Produce
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Produce) ? record_or_id : Produce.find(record_or_id)
      record.destroy
    end
end
