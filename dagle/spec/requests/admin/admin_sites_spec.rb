require 'rails_helper'

RSpec.describe "Admin::Sites", type: :request do
  describe "GET /admin_sites" do
    login_admin
    it "works! (now write some real specs)" do
      get admin_sites_path
      expect(response).to have_http_status(200)
    end
  end
end
