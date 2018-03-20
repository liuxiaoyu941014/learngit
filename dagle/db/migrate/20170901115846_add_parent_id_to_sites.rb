class AddParentIdToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :parent_id, :integer
    add_index :sites, :parent_id
  end
end
