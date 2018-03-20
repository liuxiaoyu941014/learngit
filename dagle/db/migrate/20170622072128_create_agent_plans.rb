class CreateAgentPlans < ActiveRecord::Migration[5.0]
    def change
      # 商家套餐
      create_table :agent_plans do |t|
        t.string :name
        t.string :features, array: true
        t.text   :description
        t.timestamps
      end
    end
  end
  