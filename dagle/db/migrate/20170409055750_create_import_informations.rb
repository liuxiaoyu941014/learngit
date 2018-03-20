class CreateImportInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :import_informations do |t|
      t.string :origin_type, index: true
      t.string :file_name
      t.integer :line
      t.string :name
      t.jsonb :features
      t.string :is_parsed

      t.timestamps
    end
  end
end
