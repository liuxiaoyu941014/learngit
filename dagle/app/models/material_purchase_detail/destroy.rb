class MaterialPurchaseDetail
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(MaterialPurchaseDetail) ? record_or_id : MaterialPurchaseDetail.find(record_or_id)
      MaterialPurchaseDetail.transaction do
        record.destroy!
        material_purchase = record.material_purchase
        material_purchase.amount = material_purchase.material_purchase_details.map{|mpd| mpd.number * mpd.price }.sum
        material_purchase.total = material_purchase.material_purchase_details.map{|mpd| mpd.number }.sum
        material_purchase.save!
      end
    end
end
