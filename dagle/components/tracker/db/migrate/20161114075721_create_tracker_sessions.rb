class CreateTrackerSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :tracker_sessions do |t|

      t.timestamps
    end
  end
end
