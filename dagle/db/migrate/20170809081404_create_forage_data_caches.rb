class CreateForageDataCaches < ActiveRecord::Migration[5.0]
  def change
    create_table :forage_data_caches do |t|
      t.references :source, polymorphic: true, index: true
      t.string :title, index: true
      t.string :url, index: true
      t.jsonb :data
      t.integer :processed_by
      t.boolean :auto_merge, default: false
      t.integer :is_merged, index: true, default: 0

      t.timestamps
    end
  end
end
