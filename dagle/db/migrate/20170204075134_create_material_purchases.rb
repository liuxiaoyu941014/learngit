class CreateMaterialPurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :material_purchases do |t|
      t.integer :vendor_id
      t.jsonb :features
      t.integer :created_by
      t.integer :status
      t.timestamps
    end
  end
end
