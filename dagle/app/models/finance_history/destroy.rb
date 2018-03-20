class FinanceHistory
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(FinanceHistory) ? record_or_id : FinanceHistory.find(record_or_id)
      record.destroy
    end
end
