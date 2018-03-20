require 'rails_helper'

RSpec.describe "agent/deliveries/edit", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.create!(id: 1, ))
  end
  it "renders the edit agent_delivery form" do
    render
    assert_select "form[action=?][method=?]", agent_delivery_path(@delivery), "post" do
    end
  end
end
