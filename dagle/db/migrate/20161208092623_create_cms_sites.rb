class CreateCmsSites < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_sites do |t|
      t.string :name, null: false
      t.string :template, null: false
      t.string :domain
      t.string :description
      t.jsonb  :features
      t.boolean :is_published, default: true

      t.timestamps
    end
  end
end
