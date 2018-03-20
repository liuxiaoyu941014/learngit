class ItemRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :item_relations, id: false do |t|
      t.references :master, index: true
      t.references :slave, index: true
    end
  end
end
