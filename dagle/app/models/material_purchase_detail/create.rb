class MaterialPurchaseDetail
  Create =
    lambda do |attributes, user: nil|
      record = MaterialPurchaseDetail.new(attributes)
      [record.save, record]
    end
end
