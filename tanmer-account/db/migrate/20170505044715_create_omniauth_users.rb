class CreateOmniauthUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :omniauth_users do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
