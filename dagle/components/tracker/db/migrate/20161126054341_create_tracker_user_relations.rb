class CreateTrackerUserRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :tracker_user_relations do |t|
      t.references :master, index: true
      t.references :slave, index: true

      t.timestamps
    end
  end
end
