class CreateAddressBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :address_books do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :gender
      t.string :mobile_phone, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :house_number
      t.jsonb :features
      t.string :note

      t.timestamps
    end
  end
end
