class RolesPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_permissions do |t|
      t.integer :role_id
      t.integer :permission_id
    end
    add_index :roles_permissions, [:role_id, :permission_id]
  end
end
