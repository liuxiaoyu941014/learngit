require 'rails_helper'

RSpec.describe "admin/orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :user => nil,
      :site => nil,
      :price => 1
    ))
  end
  it "renders new admin_order form" do
    render
    assert_select "form[action=?][method=?]", admin_orders_path, "post" do

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_site_id[name=?]", "order[site_id]"

      assert_select "input#order_price[name=?]", "order[price]"
    end
  end
end
