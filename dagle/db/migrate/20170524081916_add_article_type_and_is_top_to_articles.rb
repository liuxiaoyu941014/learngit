class AddArticleTypeAndIsTopToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :article_type, :integer, index: true
    add_column :articles, :is_top, :boolean, index: true, default: false
  end
end
