require 'rails_helper'

RSpec.describe "admin/material_warehouses/new", type: :view do
  before(:each) do
    assign(:material_warehouse, MaterialWarehouse.new())
  end
  it "renders new admin_material_warehouse form" do
    render
    assert_select "form[action=?][method=?]", admin_material_warehouses_path, "post" do
    end
  end
end
