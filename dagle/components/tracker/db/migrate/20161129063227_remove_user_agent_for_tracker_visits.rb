class RemoveUserAgentForTrackerVisits < ActiveRecord::Migration[5.0]
  def change
    remove_column :tracker_visits, :user_agent
    add_column :tracker_visits, :user_agent_data, :jsonb
  end
end
