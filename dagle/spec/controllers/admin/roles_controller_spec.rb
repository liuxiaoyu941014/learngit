require 'rails_helper'

RSpec.describe Admin::RolesController, type: :controller do
  login_admin

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end

end
