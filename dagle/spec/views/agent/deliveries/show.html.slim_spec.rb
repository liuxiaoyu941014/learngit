require 'rails_helper'

RSpec.describe "agent/deliveries/show", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
