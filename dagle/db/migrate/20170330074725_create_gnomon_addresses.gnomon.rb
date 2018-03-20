# This migration comes from gnomon (originally 20170326143018)
class CreateGnomonAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_addresses do |t|
      t.references :district, index: true
      t.references :street, index: true
      t.string :street_number
      t.string :name, index: true
      t.decimal :lng, precision: 20, scale: 14
      t.decimal :lat, precision: 20, scale: 14
      t.timestamps
    end
  end
end
