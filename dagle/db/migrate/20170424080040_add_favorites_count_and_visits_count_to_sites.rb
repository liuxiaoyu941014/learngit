class AddFavoritesCountAndVisitsCountToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :favorites_count, :integer, default: 0, index: true
    add_column :sites, :visits_count, :integer, default: 0, index: true
  end
end
