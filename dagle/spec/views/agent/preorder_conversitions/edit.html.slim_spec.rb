require 'rails_helper'

RSpec.describe "agent/preorder_conversitions/edit", type: :view do
  before(:each) do
    @preorder_conversition = assign(:preorder_conversition, PreorderConversition.create!(id: 1, ))
  end
  it "renders the edit agent_preorder_conversition form" do
    render
    assert_select "form[action=?][method=?]", agent_preorder_conversition_path(@preorder_conversition), "post" do
    end
  end
end
