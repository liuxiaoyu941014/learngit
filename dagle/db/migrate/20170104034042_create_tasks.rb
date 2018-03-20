class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :site, foreign_key: true
      t.string :title
      t.text :description
      t.integer :creator_id
      t.integer :assignee_id
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
