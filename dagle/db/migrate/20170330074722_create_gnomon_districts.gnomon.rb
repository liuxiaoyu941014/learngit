# This migration comes from gnomon (originally 20170326133541)
class CreateGnomonDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_districts do |t|
      t.references :city, index: true
      t.string :name, index: true

      t.timestamps
    end
  end
end
