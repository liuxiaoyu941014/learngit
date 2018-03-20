class Notification
  Create =
    lambda do |attributes, user: nil|
      record = Notification.new(attributes)
      [record.save, record]
    end
end
