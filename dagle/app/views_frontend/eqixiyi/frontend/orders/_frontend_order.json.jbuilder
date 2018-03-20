json.extract! frontend_order, :id, :user_id, :product_id, :price, :status, :created_at, :updated_at
json.url frontend_order_url(frontend_order, format: :json)
