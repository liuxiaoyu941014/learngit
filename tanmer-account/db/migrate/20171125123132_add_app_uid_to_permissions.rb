class AddAppUidToPermissions < ActiveRecord::Migration[5.1]
  def up
    add_column :permissions, :app_uid, :string
    execute("update permissions as a set app_uid = b.uid from oauth_applications as b where a.app_id = b.id")
  end
  def down
    remove_column :permissions, :app_uid
  end
end
