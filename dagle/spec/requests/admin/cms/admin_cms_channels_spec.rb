require 'rails_helper'

RSpec.describe "Admin::Cms::Channels", type: :request do
  describe "GET /admin_cms_channels" do
    it "works! (now write some real specs)" do
      get admin_cms_channels_path
      expect(response).to have_http_status(200)
    end
  end
end
