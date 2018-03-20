class ImageItemTag
  Create =
    lambda do |attributes, user: nil|
      record = ImageItemTag.new(attributes)
      [record.save, record]
    end
end
