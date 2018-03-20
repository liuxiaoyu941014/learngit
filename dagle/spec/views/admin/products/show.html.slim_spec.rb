require 'rails_helper'

RSpec.describe "admin/products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.new(id: 1,
      :site => nil,
      :name => "Name",
      :price => 2,
      :description => "Description"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Description/)
  end
end
