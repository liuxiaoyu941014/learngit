require 'rails_helper'

RSpec.describe "Agent::Deliveries", type: :request do
  describe "GET /agent_deliveries" do
    it "works! (now write some real specs)" do
      get agent_deliveries_path
      expect(response).to have_http_status(200)
    end
  end
end
