require 'rails_helper'

RSpec.describe "frontend/orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :user => nil,
      :product => nil,
      :price => "9.99",
      :status => "MyString"
    ))
  end
  it "renders new frontend_order form" do
    render
    assert_select "form[action=?][method=?]", frontend_orders_path, "post" do

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_product_id[name=?]", "order[product_id]"

      assert_select "input#order_price[name=?]", "order[price]"

      assert_select "input#order_status[name=?]", "order[status]"
    end
  end
end
