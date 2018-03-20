class CreateMaterialPurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :material_purchase_details do |t|
      t.integer :material_id
      t.references :material_purchase, foreign_key: true
      t.integer :number #采购数量
      t.integer :input_number, default: 0 #已入库数量
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
