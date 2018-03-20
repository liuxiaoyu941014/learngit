require 'rails_helper'

RSpec.describe "Admin::Catalogs", type: :request do
  describe "GET /admin_catalogs" do
    it "works! (now write some real specs)" do
      get admin_catalogs_path
      expect(response).to have_http_status(200)
    end
  end
end
