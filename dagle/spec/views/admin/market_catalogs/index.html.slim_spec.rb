require 'rails_helper'

RSpec.describe "admin/market_catalogs/index", type: :view do
  before(:each) do
    assign(:market_catalogs, [
      MarketCatalog.new(id: 1,),
      MarketCatalog.new(id: 2,)
    ])
  end
  it "renders a list of admin/market_catalogs" do
    render
  end
end
