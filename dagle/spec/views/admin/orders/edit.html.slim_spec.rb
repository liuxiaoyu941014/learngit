require 'rails_helper'

RSpec.describe "admin/orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(id: 1, 
      :user => nil,
      :site => nil,
      :price => 1
    ))
  end
  it "renders the edit admin_order form" do
    render
    assert_select "form[action=?][method=?]", admin_order_path(@order), "post" do

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_site_id[name=?]", "order[site_id]"

      assert_select "input#order_price[name=?]", "order[price]"
    end
  end
end
