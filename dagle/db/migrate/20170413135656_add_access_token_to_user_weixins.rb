class AddAccessTokenToUserWeixins < ActiveRecord::Migration[5.0]
  def change
    add_column :user_weixins, :access_token, :string
  end
end
