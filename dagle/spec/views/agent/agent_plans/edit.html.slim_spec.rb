require 'rails_helper'

RSpec.describe "agent/agent_plans/edit", type: :view do
  before(:each) do
    @agent_plan = assign(:agent_plan, AgentPlan.create!(id: 1, ))
  end
  it "renders the edit agent_agent_plan form" do
    render
    assert_select "form[action=?][method=?]", agent_agent_plan_path(@agent_plan), "post" do
    end
  end
end
