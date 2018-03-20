require 'rails_helper'

RSpec.describe "admin/deliveries/index", type: :view do
  before(:each) do
    assign(:deliveries, [
      Delivery.new(id: 1,),
      Delivery.new(id: 2,)
    ])
  end
  it "renders a list of admin/deliveries" do
    render
  end
end
