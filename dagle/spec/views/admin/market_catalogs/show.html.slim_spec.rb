require 'rails_helper'

RSpec.describe "admin/market_catalogs/show", type: :view do
  before(:each) do
    @market_catalog = assign(:market_catalog, MarketCatalog.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
