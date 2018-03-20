class AddLikesCountToCommentEnties < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :likes_count, :integer, default: 0, index: true
  end
end
