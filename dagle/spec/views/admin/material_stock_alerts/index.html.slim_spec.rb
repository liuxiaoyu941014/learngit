require 'rails_helper'

RSpec.describe "admin/material_stock_alerts/index", type: :view do
  before(:each) do
    assign(:material_stock_alerts, [
      MaterialStockAlert.new(id: 1,),
      MaterialStockAlert.new(id: 2,)
    ])
  end
  it "renders a list of admin/material_stock_alerts" do
    render
  end
end
