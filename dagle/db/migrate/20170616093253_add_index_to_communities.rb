class AddIndexToCommunities < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE INDEX idx__gnomon_community on communities USING gist(ll_to_earth(lat, lng))"
  end
  def down
    execute "DROP INDEX idx__gnomon_community"
  end
end
