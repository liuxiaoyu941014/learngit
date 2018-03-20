require 'rails_helper'

RSpec.describe "admin/material_warehouses/index", type: :view do
  before(:each) do
    assign(:material_warehouses, [
      MaterialWarehouse.new(id: 1,),
      MaterialWarehouse.new(id: 2,)
    ])
  end
  it "renders a list of admin/material_warehouses" do
    render
  end
end
