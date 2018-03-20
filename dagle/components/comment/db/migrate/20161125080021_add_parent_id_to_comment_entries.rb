class AddParentIdToCommentEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :parent_id, :integer, after: :id
  end
end
