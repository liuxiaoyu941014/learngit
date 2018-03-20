class MaterialPurchase
  Create =
    lambda do |attributes, user: nil|
      record = MaterialPurchase.new(attributes)
      record.amount = record.material_purchase_details.map{|mpd| mpd.number * mpd.price }.sum
      record.total = record.material_purchase_details.map{|mpd| mpd.number }.sum
      record.created_by = user.id if user
      [record.save, record]
    end
end
