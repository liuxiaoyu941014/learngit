class AddFeaturesToStaffs < ActiveRecord::Migration[5.0]
  def change
    remove_column :staffs, :description
    add_column :staffs, :features, :jsonb
  end
end
