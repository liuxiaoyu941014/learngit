require 'rails_helper'

RSpec.describe DocsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dev" do
    it "returns http success" do
      get :dev
      expect(response).to have_http_status(:success)
    end
  end

end
