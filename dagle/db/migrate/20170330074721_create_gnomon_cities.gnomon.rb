# This migration comes from gnomon (originally 20170326133454)
class CreateGnomonCities < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_cities do |t|
      t.references :province, index: true
      t.string :name, index: true

      t.timestamps
    end
  end
end
