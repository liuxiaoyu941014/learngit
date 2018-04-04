class RemoveAppUidFromPermissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :permissions, :app_uid
  end
end
