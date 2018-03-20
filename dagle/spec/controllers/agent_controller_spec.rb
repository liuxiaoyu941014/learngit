require 'rails_helper'

RSpec.describe AgentController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #market_page" do
    it "returns http success" do
      get :market_page
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #member_new" do
    it "returns http success" do
      get :member_new
      expect(response).to have_http_status(:success)
    end
  end

end
