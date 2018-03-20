class AddTypeToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :type, :string
  end
end
