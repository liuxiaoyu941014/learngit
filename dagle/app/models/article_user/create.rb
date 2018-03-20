class ArticleUser
  Create =
    lambda do |attributes, user: nil|
      record = ArticleUser.new(attributes)
      [record.save, record]
    end
end
