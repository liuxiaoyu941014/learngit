class ArticleUser < ApplicationRecord
  audited
  belongs_to :user
  belongs_to :article
end
