require 'rails_helper'

RSpec.describe "agent/agent_plans/index", type: :view do
  before(:each) do
    assign(:agent_plans, [
      AgentPlan.new(id: 1,),
      AgentPlan.new(id: 2,)
    ])
  end
  it "renders a list of agent/agent_plans" do
    render
  end
end
