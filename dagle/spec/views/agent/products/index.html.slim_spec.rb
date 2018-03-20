require 'rails_helper'

RSpec.describe "agent/products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.new(id: 1,),
      Product.new(id: 2,)
    ])
  end
  it "renders a list of agent/products" do
    render
  end
end
