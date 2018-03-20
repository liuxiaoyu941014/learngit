class AddOrdinalToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :ordinal, :integer
    add_column :tasks, :task_type_id, :integer
    add_column :tasks, :status, :integer
  end
end
