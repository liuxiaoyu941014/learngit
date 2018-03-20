require 'rails_helper'

RSpec.describe "admin/agent_plans/index", type: :view do
  before(:each) do
    assign(:agent_plans, [
      AgentPlan.new(id: 1,
        :name => "Name",
        :description => "MyText",
        :features => "Features"
      ),
      AgentPlan.new(id: 2,
        :name => "Name",
        :description => "MyText",
        :features => "Features"
      )
    ])
  end
  it "renders a list of admin/agent_plans" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Features".to_s, :count => 2
  end
end
