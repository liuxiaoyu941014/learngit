class RemoveCurrentTaskIdToProduces < ActiveRecord::Migration[5.0]
  def change
    remove_column :produces, :current_task_id
  end
end
