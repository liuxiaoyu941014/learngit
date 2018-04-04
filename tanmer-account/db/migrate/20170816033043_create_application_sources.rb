class CreateApplicationSources < ActiveRecord::Migration[5.1]
  def change
    create_table :application_sources do |t|
      t.references :application, index: true
      t.string :source, index: true

      t.timestamps
    end
    add_index :application_sources, [:application_id, :source], unique: true
  end
end
