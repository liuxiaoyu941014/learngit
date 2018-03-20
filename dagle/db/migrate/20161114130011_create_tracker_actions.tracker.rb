# This migration comes from tracker (originally 20161114071130)
class CreateTrackerActions < ActiveRecord::Migration[5.0]
  def change
    create_table :tracker_actions do |t|
      t.string :name
      t.string :controller_path
      t.string :action_name

      t.timestamps
    end
  end
end
