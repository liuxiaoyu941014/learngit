class CreateArticleUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :article_users do |t|
      t.references :user
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
