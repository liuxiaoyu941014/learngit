require 'rails_helper'

RSpec.describe "admin/market_catalogs/new", type: :view do
  before(:each) do
    assign(:market_catalog, MarketCatalog.new())
  end
  it "renders new admin_market_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_market_catalogs_path, "post" do
    end
  end
end
