class AddUnionidToUserWeixins < ActiveRecord::Migration[5.0]
  def change
    add_column :user_weixins, :unionid, :string
  end
end
