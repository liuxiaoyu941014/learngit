json.extract! cms_page, :id, :channel_id, :title, :short_title, :properties, :keywords, :description, :image_path, :content, :created_at, :updated_at
json.url cms_page_url(cms_page, format: :json)