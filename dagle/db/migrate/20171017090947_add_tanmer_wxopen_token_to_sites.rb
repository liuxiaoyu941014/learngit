class AddTanmerWxopenTokenToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :tanmer_wxopen_token, :string
  end
end
