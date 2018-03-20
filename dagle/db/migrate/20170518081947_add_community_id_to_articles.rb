class AddCommunityIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :community_id, :integer
  end
end
