require 'rails_helper'

RSpec.describe "admin/market_templates/show", type: :view do
  before(:each) do
    @market_template = assign(:market_template, MarketTemplate.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
