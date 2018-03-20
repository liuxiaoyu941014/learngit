require 'rails_helper'

RSpec.describe "Admin::FinanceHistories", type: :request do
  describe "GET /admin_finance_histories" do
    it "works! (now write some real specs)" do
      get admin_finance_histories_path
      expect(response).to have_http_status(200)
    end
  end
end
