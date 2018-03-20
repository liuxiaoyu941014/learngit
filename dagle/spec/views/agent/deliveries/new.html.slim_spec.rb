require 'rails_helper'

RSpec.describe "agent/deliveries/new", type: :view do
  before(:each) do
    assign(:delivery, Delivery.new())
  end
  it "renders new agent_delivery form" do
    render
    assert_select "form[action=?][method=?]", agent_deliveries_path, "post" do
    end
  end
end
