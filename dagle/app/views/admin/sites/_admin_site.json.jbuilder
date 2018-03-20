json.extract! admin_site, :id, :user_id, :title, :description, :created_at, :updated_at
json.url admin_site_url(admin_site, format: :json)