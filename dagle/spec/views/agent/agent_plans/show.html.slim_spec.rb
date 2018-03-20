require 'rails_helper'

RSpec.describe "agent/agent_plans/show", type: :view do
  before(:each) do
    @agent_plan = assign(:agent_plan, AgentPlan.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
