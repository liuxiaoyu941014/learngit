require 'rails_helper'

RSpec.describe "agent/products/new", type: :view do
  before(:each) do
    assign(:product, Product.new())
  end
  it "renders new agent_product form" do
    render
    assert_select "form[action=?][method=?]", agent_products_path, "post" do
    end
  end
end
