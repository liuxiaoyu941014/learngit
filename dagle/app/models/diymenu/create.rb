class Diymenu
  Create =
    lambda do |attributes, user: nil|
      record = Diymenu.new(attributes)
      [record.save, record]
    end
end
