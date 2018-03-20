class <%= class_name %>
  Create =
    lambda do |attributes, user: nil|
      record = <%= class_name %>.new(attributes)
      [record.save, record]
    end
end
