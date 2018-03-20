class AddIsFlatformRecommendToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :is_flatform_recommend, :boolean, index: true, default: false
  end
end
