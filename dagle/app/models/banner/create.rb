class Banner
  Create =
    lambda do |attributes, user: nil|
      record = Banner.new(attributes)
      [record.save, record]
    end
end
