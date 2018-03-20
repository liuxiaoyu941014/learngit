require 'rails_helper'

RSpec.describe "Agent::PreorderConversitions", type: :request do
  describe "GET /agent_preorder_conversitions" do
    it "works! (now write some real specs)" do
      get agent_preorder_conversitions_path
      expect(response).to have_http_status(200)
    end
  end
end
