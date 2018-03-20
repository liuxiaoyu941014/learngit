class RemoveCommentsCountToCmsChannel < ActiveRecord::Migration[5.0]
  def change
    remove_column :cms_channels, :comments_count
  end
end
