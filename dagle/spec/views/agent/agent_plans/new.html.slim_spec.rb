require 'rails_helper'

RSpec.describe "agent/agent_plans/new", type: :view do
  before(:each) do
    assign(:agent_plan, AgentPlan.new())
  end
  it "renders new agent_agent_plan form" do
    render
    assert_select "form[action=?][method=?]", agent_agent_plans_path, "post" do
    end
  end
end
