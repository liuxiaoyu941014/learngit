require 'rails_helper'

RSpec.describe "admin/material_purchases/new", type: :view do
  before(:each) do
    assign(:material_purchase, MaterialPurchase.new())
  end
  it "renders new admin_material_purchase form" do
    render
    assert_select "form[action=?][method=?]", admin_material_purchases_path, "post" do
    end
  end
end
