require 'rails_helper'

RSpec.describe "Admin::Orders", type: :request do
  describe "GET /admin_orders" do
    it "works! (now write some real specs)" do
      get admin_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
