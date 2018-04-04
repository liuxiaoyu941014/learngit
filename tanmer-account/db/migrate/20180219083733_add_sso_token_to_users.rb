class AddSsoTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sso_token, :string
    add_column :users, :sso_token_expires_at, :datetime
  end
end
