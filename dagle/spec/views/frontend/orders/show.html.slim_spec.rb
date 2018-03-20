require 'rails_helper'

RSpec.describe "frontend/orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.new(id: 1,
      :user => nil,
      :product => nil,
      :price => "9.99",
      :status => "Status"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
  end
end
