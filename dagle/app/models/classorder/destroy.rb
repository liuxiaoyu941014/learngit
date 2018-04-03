class Classorder
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Classorder) ? record_or_id : Classorder.find(record_or_id)
      record.destroy
    end
end
