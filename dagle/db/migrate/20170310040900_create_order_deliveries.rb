class CreateOrderDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :order_deliveries do |t|
      t.integer :delivery_id
      t.integer :order_id
      t.jsonb :features
      t.timestamps
    end
  end
end
