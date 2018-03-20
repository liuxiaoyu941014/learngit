class AddAssetableIdToTableCkeditorAssets < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :assetable_id, :integer, { :default => "", :null => false }
    add_column :ckeditor_assets, :assetable_type, :string, { :limit => 30 }
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"
    add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  end
end
