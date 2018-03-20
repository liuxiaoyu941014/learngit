class AddPriceToAgentPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :agent_plans, :price, :integer
  end
end
