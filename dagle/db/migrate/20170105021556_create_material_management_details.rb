class CreateMaterialManagementDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :material_management_details do |t|
      t.integer :material_id
      t.references :material_management, foreign_key: true
      t.integer :number
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
