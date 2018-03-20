class ArticleProduct
  Create =
    lambda do |attributes, user: nil|
      record = ArticleProduct.new(attributes)
      [record.save, record]
    end
end
