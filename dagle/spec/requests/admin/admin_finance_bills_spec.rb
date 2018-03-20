require 'rails_helper'

RSpec.describe "Admin::FinanceBills", type: :request do
  describe "GET /admin_finance_bills" do
    it "works! (now write some real specs)" do
      get admin_finance_bills_path
      expect(response).to have_http_status(200)
    end
  end
end
