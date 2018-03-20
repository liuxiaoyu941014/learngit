require 'rails_helper'

RSpec.describe "admin/deliveries/new", type: :view do
  before(:each) do
    assign(:delivery, Delivery.new())
  end
  it "renders new admin_delivery form" do
    render
    assert_select "form[action=?][method=?]", admin_deliveries_path, "post" do
    end
  end
end
