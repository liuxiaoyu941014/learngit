# This migration comes from comment (originally 20161116081426)
class CreateCommentEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_entries do |t|
      t.integer :user_id
      t.references :resource, polymorphic: true
      t.text :content
      t.integer :position
      t.boolean :deleted

      t.timestamps
    end
  end
end
