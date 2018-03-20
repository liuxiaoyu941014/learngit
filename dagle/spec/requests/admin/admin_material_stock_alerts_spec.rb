require 'rails_helper'

RSpec.describe "Admin::MaterialStockAlerts", type: :request do
  describe "GET /admin_material_stock_alerts" do
    it "works! (now write some real specs)" do
      get admin_material_stock_alerts_path
      expect(response).to have_http_status(200)
    end
  end
end
