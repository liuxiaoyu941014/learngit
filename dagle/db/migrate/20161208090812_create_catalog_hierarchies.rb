class CreateCatalogHierarchies < ActiveRecord::Migration
  def change
    create_table :catalog_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :catalog_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "catalog_anc_desc_idx"

    add_index :catalog_hierarchies, [:descendant_id],
      name: "catalog_desc_idx"
  end
end
