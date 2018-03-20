class ImageItemRelation
  Create =
    lambda do |attributes, user: nil|
      record = ImageItemRelation.new(attributes)
      [record.save, record]
    end
end
