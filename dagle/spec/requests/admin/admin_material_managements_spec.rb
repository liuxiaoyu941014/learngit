require 'rails_helper'

RSpec.describe "Admin::MaterialManagements", type: :request do
  describe "GET /admin_material_managements" do
    it "works! (now write some real specs)" do
      get admin_material_managements_path
      expect(response).to have_http_status(200)
    end
  end
end
