require 'rails_helper'

RSpec.describe "agent/preorder_conversitions/new", type: :view do
  before(:each) do
    assign(:preorder_conversition, PreorderConversition.new())
  end
  it "renders new agent_preorder_conversition form" do
    render
    assert_select "form[action=?][method=?]", agent_preorder_conversitions_path, "post" do
    end
  end
end
