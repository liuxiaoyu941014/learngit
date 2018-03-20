json.extract! cms_comment, :id, :contact, :content, :features, :created_at, :updated_at
json.url cms_comment_url(cms_comment, format: :json)
