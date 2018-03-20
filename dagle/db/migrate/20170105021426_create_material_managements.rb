class CreateMaterialManagements < ActiveRecord::Migration[5.0]
  def change
    create_table :material_managements do |t|
      t.string :note
      t.integer :operate_type
      t.date :operate_date

      t.timestamps
    end
  end
end
