class AddSiteIdToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :site_id, :integer
  end
end
