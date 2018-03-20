# This migration comes from gnomon (originally 20170327075734)
class CreateGnomonRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_regions do |t|
      t.references :district, index: true
      t.string :name, index: true
      t.string :tag, index: true

      t.timestamps
    end
  end
end
