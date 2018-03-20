require 'rails_helper'

RSpec.describe Agent::AssetsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #intranet_images" do
    it "returns http success" do
      get :intranet_images
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #extranet_images" do
    it "returns http success" do
      get :extranet_images
      expect(response).to have_http_status(:success)
    end
  end

end
