class AddRefreshTokenToUserWeixins < ActiveRecord::Migration[5.0]
  def change
    add_column :user_weixins, :refresh_token, :string
  end
end
