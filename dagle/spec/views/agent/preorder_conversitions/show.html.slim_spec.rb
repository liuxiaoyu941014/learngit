require 'rails_helper'

RSpec.describe "agent/preorder_conversitions/show", type: :view do
  before(:each) do
    @preorder_conversition = assign(:preorder_conversition, PreorderConversition.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
