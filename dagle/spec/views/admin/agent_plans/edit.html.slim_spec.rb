require 'rails_helper'

RSpec.describe "admin/agent_plans/edit", type: :view do
  before(:each) do
    @agent_plan = assign(:agent_plan, AgentPlan.create!(id: 1, 
      :name => "MyString",
      :description => "MyText",
      :features => "MyString"
    ))
  end
  it "renders the edit admin_agent_plan form" do
    render
    assert_select "form[action=?][method=?]", admin_agent_plan_path(@agent_plan), "post" do

      assert_select "input#agent_plan_name[name=?]", "agent_plan[name]"

      assert_select "textarea#agent_plan_description[name=?]", "agent_plan[description]"

      assert_select "input#agent_plan_features[name=?]", "agent_plan[features]"
    end
  end
end
