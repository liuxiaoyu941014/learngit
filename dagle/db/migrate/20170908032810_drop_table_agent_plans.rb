class DropTableAgentPlans < ActiveRecord::Migration[5.0]
  def change
    drop_table :agent_plans
  end
end
