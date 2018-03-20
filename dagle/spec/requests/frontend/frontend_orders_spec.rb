require 'rails_helper'

RSpec.describe "Frontend::Orders", type: :request do
  describe "GET /frontend_orders" do
    it "works! (now write some real specs)" do
      get frontend_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
