require 'rails_helper'

RSpec.describe "Agent::AgentPlans", type: :request do
  describe "GET /agent_agent_plans" do
    it "works! (now write some real specs)" do
      get agent_agent_plans_path
      expect(response).to have_http_status(200)
    end
  end
end
