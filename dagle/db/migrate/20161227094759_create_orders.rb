class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
