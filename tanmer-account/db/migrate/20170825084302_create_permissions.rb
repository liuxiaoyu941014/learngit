class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :app
      t.string :name
      t.string :group_name
      t.string :subject_class
      t.string :subject_id
      t.string :action
      t.string :description
      t.timestamps
    end
    add_index :permissions, [:app_id, :subject_class, :action], name: 'idx__permissions'
  end
end
