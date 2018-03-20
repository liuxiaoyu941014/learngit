class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string :name
      t.string :display_name
      t.text :config

      t.timestamps
    end
  end
end
