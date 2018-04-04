class AddImageToOmniauthUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :omniauth_users, :image, :string
  end
end
