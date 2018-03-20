class CreateImageItems < ActiveRecord::Migration[5.0]
  def change
    create_table :image_items do |t|
      t.references :owner, polymorphic: true
      t.string :name
      t.integer :file_size
      t.integer :width
      t.integer :height
      t.jsonb :data

      t.timestamps
    end
  end
end
