class CreateTaskTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :task_types do |t|
      t.string :type
      t.string :name
      t.integer :ordinal
      t.jsonb :roles

      t.timestamps
    end
  end
end
