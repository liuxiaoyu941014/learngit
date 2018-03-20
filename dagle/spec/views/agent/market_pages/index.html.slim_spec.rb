require 'rails_helper'

RSpec.describe "agent/market_pages/index", type: :view do
  before(:each) do
    assign(:market_pages, [
      MarketPage.new(id: 1,),
      MarketPage.new(id: 2,)
    ])
  end
  it "renders a list of agent/market_pages" do
    render
  end
end
