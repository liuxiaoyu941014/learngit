require 'rails_helper'

RSpec.describe "admin/order_materials/show", type: :view do
  before(:each) do
    @order_material = assign(:order_material, OrderMaterial.new(id: 1,
      :material => nil,
      :amount => 2
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
