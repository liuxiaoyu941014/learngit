class Cms::Comment
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Cms::Comment) ? record_or_id : Cms::Comment.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
