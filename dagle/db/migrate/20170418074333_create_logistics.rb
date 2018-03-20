class CreateLogistics < ActiveRecord::Migration[5.0]
  def change
    create_table :logistics do |t|
      t.integer :order_delivery_id
      t.integer :delivery_id
      t.integer :status
      t.integer :update_by
      t.integer :create_by

      t.timestamps
    end
  end
end
