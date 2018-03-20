class RemoveSiteIdToStaffs < ActiveRecord::Migration[5.0]
  def change
    remove_column :staffs, :site_id
  end
end
