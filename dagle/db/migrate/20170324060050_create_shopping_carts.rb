class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_carts do |t|
      t.references :product
      t.integer :price
      t.integer :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
