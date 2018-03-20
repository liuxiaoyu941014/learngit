class Material
  Create =
    lambda do |attributes, user: nil|
      record = Material.new(attributes)
      [record.save, record]
    end
end
