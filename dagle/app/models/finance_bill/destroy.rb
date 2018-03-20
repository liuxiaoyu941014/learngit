class FinanceBill
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(FinanceBill) ? record_or_id : FinanceBill.find(record_or_id)
      record.destroy
    end
end
