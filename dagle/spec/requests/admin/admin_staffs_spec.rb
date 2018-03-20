require 'rails_helper'

RSpec.describe "Admin::Staffs", type: :request do
  describe "GET /admin_staffs" do
    it "works! (now write some real specs)" do
      get admin_staffs_path
      expect(response).to have_http_status(200)
    end
  end
end
