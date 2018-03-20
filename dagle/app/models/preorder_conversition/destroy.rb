class PreorderConversition
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(PreorderConversition) ? record_or_id : PreorderConversition.find(record_or_id)
      record.destroy
    end
end
