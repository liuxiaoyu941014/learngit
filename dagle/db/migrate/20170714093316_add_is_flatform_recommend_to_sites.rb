class AddIsFlatformRecommendToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :is_flatform_recommend, :boolean, index: true, default: false
  end
end
