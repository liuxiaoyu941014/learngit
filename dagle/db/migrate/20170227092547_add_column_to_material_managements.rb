class AddColumnToMaterialManagements < ActiveRecord::Migration[5.0]
  def change
    add_column :material_managements, :created_by, :string
  end
end
