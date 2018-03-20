# This migration comes from gnomon (originally 20170326135433)
class CreateGnomonBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_businesses do |t|
      t.string :name, index: true

      t.timestamps
    end
    create_table :gnomon_districts_businiesses, id: false do |t|
      t.references :district, index: true
      t.references :business, index: true
    end
  end
end
