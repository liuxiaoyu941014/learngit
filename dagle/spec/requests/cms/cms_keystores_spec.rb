require 'rails_helper'

RSpec.describe "Cms::Keystores", type: :request do
  describe "GET /cms_keystores" do
    it "works! (now write some real specs)" do
      get cms_keystores_path
      expect(response).to have_http_status(200)
    end
  end
end
