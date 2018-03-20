class CreateImageItemTags < ActiveRecord::Migration[5.0]
  def change
    create_table :image_item_tags do |t|
      t.references :image_item, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
