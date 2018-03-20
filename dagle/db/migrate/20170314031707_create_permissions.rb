class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :symbol_name, index: true
      t.string :name, index: true
      t.string :group_name
      t.string :description
      t.timestamps
    end
  end
end
