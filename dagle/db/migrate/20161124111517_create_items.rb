class CreateItems < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :items do |t|
      t.references :site, foreign_key: true
      t.string :name
      t.jsonb :features

      t.timestamps
    end
  end
end
