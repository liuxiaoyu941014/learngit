require 'rails_helper'

RSpec.describe "Admin::Members", type: :request do
  describe "GET /admin_members" do
    it "works! (now write some real specs)" do
      get admin_members_path
      expect(response).to have_http_status(200)
    end
  end
end
