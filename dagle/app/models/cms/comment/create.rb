class Cms::Comment
  Create =
    lambda do |attributes, user: nil|
      record = Cms::Comment.new(attributes)
      [record.save, record]
    end
end
