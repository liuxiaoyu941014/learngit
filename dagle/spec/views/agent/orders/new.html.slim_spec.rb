require 'rails_helper'

RSpec.describe "agent/orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new())
  end
  it "renders new agent_order form" do
    render
    assert_select "form[action=?][method=?]", agent_orders_path, "post" do
    end
  end
end
