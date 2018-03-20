class Article
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Article) ? record_or_id : Article.find(record_or_id)
      record.destroy
    end
end
