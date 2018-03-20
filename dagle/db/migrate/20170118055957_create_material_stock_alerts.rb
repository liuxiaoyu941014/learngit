class CreateMaterialStockAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :material_stock_alerts do |t|
      t.integer :material_id
      t.string :title
      t.string :body
      t.integer :status

      t.timestamps
    end
  end
end
