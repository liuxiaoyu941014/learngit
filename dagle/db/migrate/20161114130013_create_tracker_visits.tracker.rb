# This migration comes from tracker (originally 20161114083606)
class CreateTrackerVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :tracker_visits do |t|
      t.references :session
      t.references :action
      t.references :user
      t.references :resource, polymorphic: true, index: true
      t.string :url
      t.string :referer
      t.text :payload
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end

    add_foreign_key :tracker_visits, :tracker_sessions, column: 'session_id'
    add_foreign_key :tracker_visits, :tracker_actions, column: 'action_id'

  end
end
