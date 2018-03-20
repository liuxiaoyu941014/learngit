class AddCatalogIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :catalog_id, :integer
  end
end
