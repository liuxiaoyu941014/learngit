require 'rails_helper'

RSpec.describe "admin/material_warehouses/edit", type: :view do
  before(:each) do
    @material_warehouse = assign(:material_warehouse, MaterialWarehouse.create!(id: 1, ))
  end
  it "renders the edit admin_material_warehouse form" do
    render
    assert_select "form[action=?][method=?]", admin_material_warehouse_path(@material_warehouse), "post" do
    end
  end
end
