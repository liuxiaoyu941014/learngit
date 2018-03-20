# This migration comes from comment (originally 20170215053355)
class AddFeaturesToCommentEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :features, :jsonb
  end
end
