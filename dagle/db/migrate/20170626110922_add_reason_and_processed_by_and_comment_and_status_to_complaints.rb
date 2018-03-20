class AddReasonAndProcessedByAndCommentAndStatusToComplaints < ActiveRecord::Migration[5.0]
  def change
    remove_column :complaints, :content, :text

    add_column :complaints, :reason, :text
    add_column :complaints, :processed_by, :integer
    add_column :complaints, :comment, :text
    add_column :complaints, :status, :integer, index: true
  end
end
