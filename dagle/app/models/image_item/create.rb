class ImageItem
  Create =
    lambda do |attributes, user: nil|
      record = ImageItem.new(attributes)
      [record.save, record]
    end
end
