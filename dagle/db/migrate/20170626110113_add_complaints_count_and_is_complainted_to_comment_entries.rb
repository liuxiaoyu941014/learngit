class AddComplaintsCountAndIsComplaintedToCommentEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_entries, :complaints_count, :integer, defalut: 0
    add_column :comment_entries, :is_complainted, :boolean, index: true, defalut: false
  end
end
