require 'rails_helper'

RSpec.describe "Admin::Vendors", type: :request do
  describe "GET /admin_vendors" do
    it "works! (now write some real specs)" do
      get admin_vendors_path
      expect(response).to have_http_status(200)
    end
  end
end
