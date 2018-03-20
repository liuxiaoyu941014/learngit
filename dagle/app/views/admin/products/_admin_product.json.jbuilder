json.extract! admin_product, :id, :site_id, :name, :price, :description, :created_at, :updated_at
json.url admin_product_url(admin_product, format: :json)