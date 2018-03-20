require 'rails_helper'

RSpec.describe "agent/orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.new(id: 1,),
      Order.new(id: 2,)
    ])
  end
  it "renders a list of agent/orders" do
    render
  end
end
