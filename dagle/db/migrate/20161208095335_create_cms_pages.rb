class CreateCmsPages < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_pages do |t|
      t.integer :channel_id, null: false, index: true
      t.string :title, null: false
      t.string :short_title, null: false, index: true
      t.string :properties
      t.string :keywords
      t.string :description
      t.string :image_path
      t.text :content

      t.timestamps
    end

  end
end
