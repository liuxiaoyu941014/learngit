require 'rails_helper'

RSpec.describe "Cms::Channels", type: :request do
  describe "GET /cms_channels" do
    it "works! (now write some real specs)" do
      get cms_channels_path
      expect(response).to have_http_status(200)
    end
  end
end
