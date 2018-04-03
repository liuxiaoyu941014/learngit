class Classorder
  Create =
    lambda do |attributes, user: nil|
      record = Classorder.new(attributes)
      [record.save, record]
    end
end
