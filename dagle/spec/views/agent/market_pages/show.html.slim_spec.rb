require 'rails_helper'

RSpec.describe "agent/market_pages/show", type: :view do
  before(:each) do
    @market_page = assign(:market_page, MarketPage.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
