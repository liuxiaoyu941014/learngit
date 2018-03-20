class CreateCmsComments < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_comments do |t|
      t.references :site, foreign_key: true
      t.string :contact
      t.text :content
      t.jsonb :features

      t.timestamps
    end
  end
end
