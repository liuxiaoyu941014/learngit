class CreateUserWeixins < ActiveRecord::Migration[5.0]
  def change
    create_table :user_weixins do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :name
      t.string :headshot
      t.string :city
      t.string :province
      t.string :country
      t.integer :gender

      t.timestamps
    end
  end
end
