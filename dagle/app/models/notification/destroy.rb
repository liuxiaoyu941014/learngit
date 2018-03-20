class Notification
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Notification) ? record_or_id : Notification.find(record_or_id)
      record.destroy
    end
end
