require 'rails_helper'

RSpec.describe "admin/material_purchases/edit", type: :view do
  before(:each) do
    @material_purchase = assign(:material_purchase, MaterialPurchase.create!(id: 1, ))
  end
  it "renders the edit admin_material_purchase form" do
    render
    assert_select "form[action=?][method=?]", admin_material_purchase_path(@material_purchase), "post" do
    end
  end
end
