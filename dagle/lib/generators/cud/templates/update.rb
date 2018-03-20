class <%= class_name %>
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(<%= class_name %>) ? record_or_id : <%= class_name %>.find(record_or_id)
      record.assign_attributes attributes
      [record.save, record]
    end
end
