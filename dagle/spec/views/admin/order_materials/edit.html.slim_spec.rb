require 'rails_helper'

RSpec.describe "admin/order_materials/edit", type: :view do
  before(:each) do
    @order_material = assign(:order_material, OrderMaterial.create!(id: 1, 
      :material => nil,
      :amount => 1
    ))
  end
  it "renders the edit admin_order_material form" do
    render
    assert_select "form[action=?][method=?]", admin_order_material_path(@order_material), "post" do

      assert_select "input#order_material_material_id[name=?]", "order_material[material_id]"

      assert_select "input#order_material_amount[name=?]", "order_material[amount]"
    end
  end
end
