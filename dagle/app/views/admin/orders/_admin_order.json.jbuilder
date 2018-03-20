json.extract! admin_order, :id, :user_id, :site_id, :price, :created_at, :updated_at
json.url admin_order_url(admin_order, format: :json)