class AddMaterialWarehouseIdToMaterialManagements < ActiveRecord::Migration[5.0]
  def change
    add_column :material_managements, :material_warehouse_id, :integer
  end
end
