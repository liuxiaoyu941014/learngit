class AddFeaturesToSites < ActiveRecord::Migration[5.0]
  def change
    remove_column :sites, :description
    add_column :sites, :features, :jsonb
  end
end
