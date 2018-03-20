require 'rails_helper'

RSpec.describe "admin/market_catalogs/edit", type: :view do
  before(:each) do
    @market_catalog = assign(:market_catalog, MarketCatalog.create!(id: 1, ))
  end
  it "renders the edit admin_market_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_market_catalog_path(@market_catalog), "post" do
    end
  end
end
