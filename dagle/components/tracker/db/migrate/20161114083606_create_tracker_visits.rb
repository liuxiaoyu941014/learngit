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

    add_foreign_key :tracker_visits, :tracker_sessions
    add_foreign_key :tracker_visits, :tracker_actions

  end
end
