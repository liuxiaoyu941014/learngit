require 'rails_helper'

RSpec.describe "frontend/orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.new(id: 1,
        :user => nil,
        :product => nil,
        :price => "9.99",
        :status => "Status"
      ),
      Order.new(id: 2,
        :user => nil,
        :product => nil,
        :price => "9.99",
        :status => "Status"
      )
    ])
  end
  it "renders a list of frontend/orders" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
