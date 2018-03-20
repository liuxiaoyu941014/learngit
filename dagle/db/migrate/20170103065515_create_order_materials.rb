class CreateOrderMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :order_materials do |t|
      t.references :order, foreign_key: true
      t.integer :material_id
      t.integer :amount

      t.timestamps
    end
  end
end
