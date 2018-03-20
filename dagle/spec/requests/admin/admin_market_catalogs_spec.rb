require 'rails_helper'

RSpec.describe "Admin::MarketCatalogs", type: :request do
  describe "GET /admin_market_catalogs" do
    it "works! (now write some real specs)" do
      get admin_market_catalogs_path
      expect(response).to have_http_status(200)
    end
  end
end
