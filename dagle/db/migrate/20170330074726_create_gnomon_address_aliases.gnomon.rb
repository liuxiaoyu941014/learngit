# This migration comes from gnomon (originally 20170327071027)
class CreateGnomonAddressAliases < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_address_aliases do |t|
      t.references :address, index: true
      t.string :alias, index: true
      t.boolean :precise
      t.integer :confidence

      t.timestamps
    end
  end
end
