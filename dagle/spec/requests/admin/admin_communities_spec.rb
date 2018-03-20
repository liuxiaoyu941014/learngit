require 'rails_helper'

RSpec.describe "Admin::Communities", type: :request do
  describe "GET /admin_communities" do
    it "works! (now write some real specs)" do
      get admin_communities_path
      expect(response).to have_http_status(200)
    end
  end
end
