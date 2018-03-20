require 'rails_helper'

RSpec.describe "agent/products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(id: 1, ))
  end
  it "renders the edit agent_product form" do
    render
    assert_select "form[action=?][method=?]", agent_product_path(@product), "post" do
    end
  end
end
