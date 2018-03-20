class Cms::Comment
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Cms::Comment) ? record_or_id : Cms::Comment.find(record_or_id)
      record.destroy
    end
end
