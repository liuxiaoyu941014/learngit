require 'rails_helper'

RSpec.describe "admin/order_materials/new", type: :view do
  before(:each) do
    assign(:order_material, OrderMaterial.new(
      :material => nil,
      :amount => 1
    ))
  end
  it "renders new admin_order_material form" do
    render
    assert_select "form[action=?][method=?]", admin_order_materials_path, "post" do

      assert_select "input#order_material_material_id[name=?]", "order_material[material_id]"

      assert_select "input#order_material_amount[name=?]", "order_material[amount]"
    end
  end
end
