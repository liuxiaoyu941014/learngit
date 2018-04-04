class CreateRolesPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :roles_permissions, id: false do |t|
      t.references :role, index: true
      t.references :permission, index: true
    end
  end
end
