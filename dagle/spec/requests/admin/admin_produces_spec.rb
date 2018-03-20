require 'rails_helper'

RSpec.describe "Admin::Produces", type: :request do
  describe "GET /admin_produces" do
    it "works! (now write some real specs)" do
      get admin_produces_path
      expect(response).to have_http_status(200)
    end
  end
end
