class UsersPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :users_permissions do |t|
      t.integer :user_id
      t.integer :permission_id
    end
    add_index :users_permissions, [:user_id, :permission_id]
  end
end
