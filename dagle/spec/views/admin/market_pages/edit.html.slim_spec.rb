require 'rails_helper'

RSpec.describe "admin/market_pages/edit", type: :view do
  before(:each) do
    @market_page = assign(:market_page, MarketPage.create!(id: 1, ))
  end
  it "renders the edit admin_market_page form" do
    render
    assert_select "form[action=?][method=?]", admin_market_page_path(@market_page), "post" do
    end
  end
end
