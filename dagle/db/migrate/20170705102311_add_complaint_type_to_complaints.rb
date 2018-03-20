class AddComplaintTypeToComplaints < ActiveRecord::Migration[5.0]
  def change
    add_column :complaints, :complaint_type, :integer, index: true
  end
end
