class AddCatalogIdToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :catalog_id, :integer
  end
end
