require 'rails_helper'

RSpec.describe "agent/orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
