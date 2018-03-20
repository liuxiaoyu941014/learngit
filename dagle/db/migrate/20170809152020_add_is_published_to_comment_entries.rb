class AddIsPublishedToCommentEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :is_published, :boolean, default: true
  end
end
