class Logistic
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Logistic) ? record_or_id : Logistic.find(record_or_id)
      record.destroy
    end
end
