require 'rails_helper'

RSpec.describe "Admin::Deliveries", type: :request do
  describe "GET /admin_deliveries" do
    it "works! (now write some real specs)" do
      get admin_deliveries_path
      expect(response).to have_http_status(200)
    end
  end
end
