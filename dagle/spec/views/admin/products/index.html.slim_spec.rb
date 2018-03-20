require 'rails_helper'

RSpec.describe "admin/products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.new(id: 1,
        :site => nil,
        :name => "Name",
        :price => 2,
        :description => "Description"
      ),
      Product.new(id: 2,
        :site => nil,
        :name => "Name",
        :price => 2,
        :description => "Description"
      )
    ])
  end
  it "renders a list of admin/products" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
