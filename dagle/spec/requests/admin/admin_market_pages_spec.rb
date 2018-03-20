require 'rails_helper'

RSpec.describe "Admin::MarketPages", type: :request do
  describe "GET /admin_market_pages" do
    it "works! (now write some real specs)" do
      get admin_market_pages_path
      expect(response).to have_http_status(200)
    end
  end
end
