# This migration comes from gnomon (originally 20170327075854)
class CreateGnomonRegionsAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :gnomon_regions_addresses, id: false do |t|
      t.references :region, index: true
      t.references :address, index: true
    end
  end
end
