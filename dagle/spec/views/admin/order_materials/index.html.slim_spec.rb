require 'rails_helper'

RSpec.describe "admin/order_materials/index", type: :view do
  before(:each) do
    assign(:order_materials, [
      OrderMaterial.new(id: 1,
        :material => nil,
        :amount => 2
      ),
      OrderMaterial.new(id: 2,
        :material => nil,
        :amount => 2
      )
    ])
  end
  it "renders a list of admin/order_materials" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
