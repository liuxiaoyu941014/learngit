class CreateProduces < ActiveRecord::Migration[5.0]
  def change
    create_table :produces do |t|
      t.references :order, foreign_key: true
      t.integer :status
      t.integer :current_task_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
