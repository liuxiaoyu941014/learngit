class CreateImportFailedInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :import_failed_informations do |t|
      t.string :origin_type, index: true
      t.string :file_name
      t.integer :line
      t.string :name
      t.jsonb :features
      t.string :is_processed, default: 'n', index: true

      t.timestamps
    end
  end
end
