json.extract! admin_cms_site, :id, :site_id, :name, :template, :domain, :description, :features, :is_published, :created_at, :updated_at
json.url admin_cms_site_url(admin_cms_site, format: :json)