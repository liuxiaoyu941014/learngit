class CreateMaterialWarehouseItems < ActiveRecord::Migration[5.0]
  def change
    create_table :material_warehouse_items do |t|
      t.integer :material_warehouse_id
      t.integer :material_id
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
