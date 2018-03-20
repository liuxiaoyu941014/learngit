class MaterialPurchase
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(MaterialPurchase) ? record_or_id : MaterialPurchase.find(record_or_id)
      record.assign_attributes attributes
      if attributes[:material_purchase_details_attributes].present?
        attributes[:material_purchase_details_attributes].each do |mpd|
          detail = record.material_purchase_details.find(mpd["id"])
          detail.input_number = mpd[:input_number]
          detail.save
        end
      end
      record.amount = record.material_purchase_details.map{|mpd| mpd.number * mpd.price }.sum
      record.total = record.material_purchase_details.map{|mpd| mpd.number }.sum
      [record.save, record]
    end
end