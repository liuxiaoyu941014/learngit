class CreateMarketPages < ActiveRecord::Migration[5.0]
  def change
    create_table :market_pages do |t|
      t.references :site, foreign_key: true
      t.references :market_template, foreign_key: true
      t.string :name
      t.string :description
      t.jsonb :features

      t.timestamps
    end
  end
end
