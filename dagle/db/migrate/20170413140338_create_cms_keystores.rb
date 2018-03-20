class CreateCmsKeystores < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_keystores do |t|
      t.references :site, foreign_key: true
      t.string :key, null: false, index: true
      t.string :value, null: false
      t.string :description

      t.timestamps
    end
  end
end
