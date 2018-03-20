# This migration comes from gnomon (originally 20170328013949)
class CreateGeoIndexToAddresses < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE INDEX idx__gnomon_address_geo on #{Gnomon::Address.table_name} USING gist(ll_to_earth(lat, lng))"
  end
  def down
    execute "DROP INDEX idx__gnomon_address_geo"
  end
end
