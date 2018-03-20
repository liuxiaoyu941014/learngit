require 'rails_helper'

RSpec.describe "admin/market_pages/new", type: :view do
  before(:each) do
    assign(:market_page, MarketPage.new())
  end
  it "renders new admin_market_page form" do
    render
    assert_select "form[action=?][method=?]", admin_market_pages_path, "post" do
    end
  end
end
