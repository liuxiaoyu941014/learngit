require 'rails_helper'

RSpec.describe "admin/orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.new(id: 1,
      :user => nil,
      :site => nil,
      :price => 2
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
