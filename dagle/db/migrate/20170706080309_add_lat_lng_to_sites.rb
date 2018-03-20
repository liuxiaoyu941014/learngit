class AddLatLngToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :lng, :decimal, precision: 20, scale: 14
    add_column :sites, :lat, :decimal, precision: 20, scale: 14
  end
end
