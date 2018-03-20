require 'rails_helper'

RSpec.describe "Cms::Sites", type: :request do
  describe "GET /cms_sites" do
    it "works! (now write some real specs)" do
      get cms_sites_path
      expect(response).to have_http_status(200)
    end
  end
end
