require 'rails_helper'

RSpec.describe "admin/material_purchases/index", type: :view do
  before(:each) do
    assign(:material_purchases, [
      MaterialPurchase.new(id: 1,),
      MaterialPurchase.new(id: 2,)
    ])
  end
  it "renders a list of admin/material_purchases" do
    render
  end
end
