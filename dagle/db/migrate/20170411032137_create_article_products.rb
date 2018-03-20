class CreateArticleProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :article_products do |t|
      t.references :article, foreign_key: true
      t.references :product
      t.timestamps
    end
  end
end
