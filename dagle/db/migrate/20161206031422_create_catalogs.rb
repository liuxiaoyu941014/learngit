class CreateCatalogs < ActiveRecord::Migration[5.0]
  def change
    create_table :catalogs do |t|
      t.references :parent
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
