# This migration comes from gnomon (originally 20170326141852)
class CreateGnomonStreets < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_streets do |t|
      t.string :name, index: true

      t.timestamps
    end
    create_table :gnomon_districts_streets, id: false do |t|
      t.references :district, index: true
      t.references :street, index: true
    end
  end
end
