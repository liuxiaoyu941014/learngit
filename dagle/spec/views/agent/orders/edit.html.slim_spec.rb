require 'rails_helper'

RSpec.describe "agent/orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(id: 1, ))
  end
  it "renders the edit agent_order form" do
    render
    assert_select "form[action=?][method=?]", agent_order_path(@order), "post" do
    end
  end
end
