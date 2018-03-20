class AddFeaturesToCommentEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :features, :jsonb
  end
end
