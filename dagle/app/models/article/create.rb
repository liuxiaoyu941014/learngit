class Article
  Create =
    lambda do |attributes, user: nil|
      record = Article.new(attributes)
      [record.save, record]
    end
end
