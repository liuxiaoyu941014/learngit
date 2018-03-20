require 'rails_helper'

RSpec.describe "agent/market_pages/new", type: :view do
  before(:each) do
    assign(:market_page, MarketPage.new())
  end
  it "renders new agent_market_page form" do
    render
    assert_select "form[action=?][method=?]", agent_market_pages_path, "post" do
    end
  end
end
