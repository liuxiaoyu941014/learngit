require 'rails_helper'

RSpec.describe "agent/preorder_conversitions/index", type: :view do
  before(:each) do
    assign(:preorder_conversitions, [
      PreorderConversition.new(id: 1,),
      PreorderConversition.new(id: 2,)
    ])
  end
  it "renders a list of agent/preorder_conversitions" do
    render
  end
end
