class AddSiteIdToCmsSites < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_sites, :site_id, :integer
    add_index :cms_sites, :site_id
  end
end
