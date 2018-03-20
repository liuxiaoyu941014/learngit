require 'rails_helper'

RSpec.describe "Agent::FinanceBills", type: :request do
  describe "GET /agent_finance_bills" do
    it "works! (now write some real specs)" do
      get agent_finance_bills_path
      expect(response).to have_http_status(200)
    end
  end
end
