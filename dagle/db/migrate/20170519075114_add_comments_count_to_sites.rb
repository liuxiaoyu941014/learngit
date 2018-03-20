class AddCommentsCountToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :comments_count, :integer
  end
end
