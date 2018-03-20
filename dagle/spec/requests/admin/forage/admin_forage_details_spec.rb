require 'rails_helper'

RSpec.describe "Admin::Forage::Details", type: :request do
  describe "GET /admin_forage_details" do
    it "works! (now write some real specs)" do
      get admin_forage_details_path
      expect(response).to have_http_status(200)
    end
  end
end
