require 'rails_helper'

RSpec.describe "admin/agent_plans/show", type: :view do
  before(:each) do
    @agent_plan = assign(:agent_plan, AgentPlan.new(id: 1,
      :name => "Name",
      :description => "MyText",
      :features => "Features"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Features/)
  end
end
