require 'rails_helper'

RSpec.describe "agent/market_pages/edit", type: :view do
  before(:each) do
    @market_page = assign(:market_page, MarketPage.create!(id: 1, ))
  end
  it "renders the edit agent_market_page form" do
    render
    assert_select "form[action=?][method=?]", agent_market_page_path(@market_page), "post" do
    end
  end
end
