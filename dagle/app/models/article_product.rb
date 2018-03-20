class ArticleProduct < ApplicationRecord
  audited
  belongs_to :article
  belongs_to :product
end
