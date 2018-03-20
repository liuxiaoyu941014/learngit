class FixComplaintsCountAndIsComplaintedForArticleAndCommentEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :complaints_count, :integer
    remove_column :articles, :is_complainted, :boolean

    remove_column :comment_entries, :complaints_count, :integer
    remove_column :comment_entries, :is_complainted, :boolean

    add_column :articles, :complaints_count, :integer, default: 0
    add_column :articles, :is_complainted, :boolean, index: true, default: false

    add_column :comment_entries, :complaints_count, :integer, default: 0
    add_column :comment_entries, :is_complainted, :boolean, index: true, default: false
  end
end
