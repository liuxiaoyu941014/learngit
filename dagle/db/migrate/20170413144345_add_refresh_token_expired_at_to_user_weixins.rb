class AddRefreshTokenExpiredAtToUserWeixins < ActiveRecord::Migration[5.0]
  def change
    add_column :user_weixins, :refresh_token_expired_at, :datetime
  end
end
