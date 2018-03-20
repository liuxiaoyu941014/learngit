class AddAgentPlanIdToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :agent_plan_id, :integer
  end
end
