class CreateThemeConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :theme_configs do |t|
      t.references :site, foreign_key: true
      t.references :theme, foreign_key: true
      t.text :config
      t.boolean :active, default: false, null: false
      t.timestamps
    end
  end
end
