require 'rails_helper'

RSpec.describe "frontend/products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :name => "MyString",
      :description => "MyString",
      :content => "MyText",
      :price => "9.99",
      :amount => 1
    ))
  end
  it "renders new frontend_product form" do
    render
    assert_select "form[action=?][method=?]", frontend_products_path, "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_description[name=?]", "product[description]"

      assert_select "textarea#product_content[name=?]", "product[content]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_amount[name=?]", "product[amount]"
    end
  end
end
