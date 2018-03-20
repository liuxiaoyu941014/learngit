require 'rails_helper'

RSpec.describe "admin/agent_plans/new", type: :view do
  before(:each) do
    assign(:agent_plan, AgentPlan.new(
      :name => "MyString",
      :description => "MyText",
      :features => "MyString"
    ))
  end
  it "renders new admin_agent_plan form" do
    render
    assert_select "form[action=?][method=?]", admin_agent_plans_path, "post" do

      assert_select "input#agent_plan_name[name=?]", "agent_plan[name]"

      assert_select "textarea#agent_plan_description[name=?]", "agent_plan[description]"

      assert_select "input#agent_plan_features[name=?]", "agent_plan[features]"
    end
  end
end
