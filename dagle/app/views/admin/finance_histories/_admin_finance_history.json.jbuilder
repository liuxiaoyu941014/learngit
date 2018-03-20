json.extract! admin_finance_history, :id, :operate_type, :operate_date, :amount, :note, :created_at, :updated_at
json.url admin_finance_history_url(admin_finance_history, format: :json)
