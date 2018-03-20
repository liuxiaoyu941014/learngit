json.extract! frontend_product, :id, :name, :description, :content, :price, :amount, :created_at, :updated_at
json.url frontend_product_url(frontend_product, format: :json)
