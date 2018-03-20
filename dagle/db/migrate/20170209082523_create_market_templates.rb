class CreateMarketTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :market_templates do |t|
      t.integer :catalog_id, null: false, index: true
      t.string :base_path, null: false
      t.string :name, null: false
      t.string :keywords
      t.string :description
      t.string :image_path
      t.text :html_source
      t.text :form_source

      t.timestamps
    end
  end
end
