json.extract! cms_site, :id, :name, :template, :domain, :description, :is_published, :created_at, :updated_at
json.url cms_site_url(cms_site, format: :json)