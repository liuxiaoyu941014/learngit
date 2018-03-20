class CreateImageItemRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :image_item_relations do |t|
      t.references :image_item, foreign_key: true
      t.references :relation, polymorphic: true

      t.timestamps
    end
  end
end
