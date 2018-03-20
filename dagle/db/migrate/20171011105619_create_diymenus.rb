class CreateDiymenus < ActiveRecord::Migration[5.0]
  def change
    create_table :diymenus do |t|
      t.references :site, index: true
      t.references :parent
      t.integer :button_type
      t.string :name, null: false
      t.string :key
      t.string :url, limit: 128
      t.boolean :is_show, default: false, null: false
      t.integer :sort, default: 1, null: false

      t.timestamps null: false
    end
    add_index :diymenus, [:site_id, :parent_id]
    add_index :diymenus, [:site_id, :key]
  end
end
