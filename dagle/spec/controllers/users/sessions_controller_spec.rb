require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  it { expect(described_class).to be < Devise::SessionsController }

  describe "impersonate" do
    login_admin
    it "returns http success" do
      agent = create(:agent)
      post :impersonate, params: { id: agent.id }
      expect(response).to redirect_to(root_path)
    end
    it "returns http success" do
      post :stop_impersonating
      expect(response).to redirect_to(root_path)
    end
  end
end
