# This migration comes from gnomon (originally 20170326133429)
class CreateGnomonProvinces < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_provinces do |t|
      t.string :name, index: true
      t.boolean :is_city

      t.timestamps
    end
  end
end
