require 'rails_helper'

RSpec.describe "admin/market_pages/index", type: :view do
  before(:each) do
    assign(:market_pages, [
      MarketPage.new(id: 1,),
      MarketPage.new(id: 2,)
    ])
  end
  it "renders a list of admin/market_pages" do
    render
  end
end
