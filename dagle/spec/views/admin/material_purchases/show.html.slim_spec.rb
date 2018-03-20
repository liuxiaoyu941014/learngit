require 'rails_helper'

RSpec.describe "admin/material_purchases/show", type: :view do
  before(:each) do
    @material_purchase = assign(:material_purchase, MaterialPurchase.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
