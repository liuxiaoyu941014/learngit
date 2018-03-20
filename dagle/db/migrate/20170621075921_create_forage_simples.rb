class CreateForageSimples < ActiveRecord::Migration[5.0]
  def change
    create_table :forage_simples do |t|
      t.integer :run_key_id, null: false, index: true
      t.string :catalog
      t.string :title
      t.string :url, null: false
      t.jsonb :features
      t.boolean :is_processed, default: false
      t.string :processed_at

      t.timestamps
    end
  end
end
