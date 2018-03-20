class AddCommentsAndFavoritesAndVisitsLikesCountToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :comments_count, :integer, default: 0, index: true
    add_column :items, :favorites_count, :integer, default: 0, index: true
    add_column :items, :visits_count, :integer, default: 0, index: true
    add_column :items, :likes_count, :integer, default: 0, index: true
  end
end
