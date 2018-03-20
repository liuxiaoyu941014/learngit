require 'rails_helper'

RSpec.describe "admin/orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.new(id: 1,
        :user => nil,
        :site => nil,
        :price => 2
      ),
      Order.new(id: 2,
        :user => nil,
        :site => nil,
        :price => 2
      )
    ])
  end
  it "renders a list of admin/orders" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
