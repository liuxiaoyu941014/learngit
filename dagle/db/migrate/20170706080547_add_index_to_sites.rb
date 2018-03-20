class AddIndexToSites < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE INDEX idx__gnomon_site on sites USING gist(ll_to_earth(lat, lng))"
  end
  def down
    execute "DROP INDEX idx__gnomon_site"
  end
end
