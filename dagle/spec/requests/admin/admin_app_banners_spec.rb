require 'rails_helper'

RSpec.describe "Admin::AppBanners", type: :request do
  describe "GET /admin_app_banners" do
    it "works! (now write some real specs)" do
      get admin_app_banners_path
      expect(response).to have_http_status(200)
    end
  end
end
