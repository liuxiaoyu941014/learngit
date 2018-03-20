require 'rails_helper'

RSpec.describe "admin/products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :site => create(:site, user: create(:agent)),
      :name => "MyString",
      :price => 1,
      :description => "MyString"
    ))
  end
  it "renders new admin_product form" do
    render
    assert_select "form[action=?][method=?]", admin_products_path, "post" do

      assert_select "select#product_site_id[name=?]", "product[site_id]"

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_description[name=?]", "product[description]"
    end
  end
end
