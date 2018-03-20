class AddFeaturesToCatalogs < ActiveRecord::Migration[5.0]
  def change
    add_column :catalogs, :features, :jsonb
  end
end
