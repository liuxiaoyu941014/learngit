class CreateCmsChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_channels do |t|
      t.integer :site_id, null: false, index: true
      t.integer :parent_id
      t.string :title, null: false
      t.string :short_title, null: false, index: true
      t.string :properties
      t.string :tmp_index, null: false
      t.string :tmp_detail, null: false
      t.string :keywords
      t.string :description
      t.string :image_path
      t.text :content

      t.timestamps
    end

  end
end
