require 'rails_helper'

RSpec.describe "Admin::AgentPlans", type: :request do
  describe "GET /admin_agent_plans" do
    it "works! (now write some real specs)" do
      get admin_agent_plans_path
      expect(response).to have_http_status(200)
    end
  end
end
