class AddAddressAliasIdToCommunities < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :address_alias_id, :integer
  end
end
