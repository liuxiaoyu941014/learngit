class CreateForageSources < ActiveRecord::Migration[5.0]
  def change
    create_table :forage_sources do |t|
      t.string :name, null: false
      t.string :catalog_name
      t.string :url
      t.string :note

      t.timestamps
    end
  end
end
