class CreateOrderProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :order_products do |t|
      t.references :order, foreign_key: true
      t.references :product
      t.integer :amount
      t.integer :price

      t.timestamps
    end
  end
end
