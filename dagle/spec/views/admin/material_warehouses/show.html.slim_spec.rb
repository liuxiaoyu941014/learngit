require 'rails_helper'

RSpec.describe "admin/material_warehouses/show", type: :view do
  before(:each) do
    @material_warehouse = assign(:material_warehouse, MaterialWarehouse.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
