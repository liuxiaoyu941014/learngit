class AddAddressAliasIdToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :address_alias_id, :integer
    add_column :sites, :address_line, :string
  end
end
