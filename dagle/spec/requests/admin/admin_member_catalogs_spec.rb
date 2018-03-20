require 'rails_helper'

RSpec.describe "Admin::MemberCatalogs", type: :request do
  describe "GET /admin_member_catalogs" do
    it "works! (now write some real specs)" do
      get admin_member_catalogs_path
      expect(response).to have_http_status(200)
    end
  end
end
