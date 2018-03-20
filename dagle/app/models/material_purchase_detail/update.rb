class MaterialPurchaseDetail
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(MaterialPurchaseDetail) ? record_or_id : MaterialPurchaseDetail.find(record_or_id)
      flag = false
      MaterialPurchaseDetail.transaction do
        record.assign_attributes attributes
        flag = record.save
        if flag
          material_purchase = record.material_purchase
          material_purchase.amount = material_purchase.material_purchase_details.map{|mpd| mpd.number * mpd.price }.sum
          material_purchase.total = material_purchase.material_purchase_details.map{|mpd| mpd.number }.sum
          material_purchase.save!
        end
      end
      [flag, record]
    end
end
