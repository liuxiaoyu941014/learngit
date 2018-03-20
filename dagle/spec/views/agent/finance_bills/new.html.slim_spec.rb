require 'rails_helper'

RSpec.describe "agent/finance_bills/new", type: :view do
  before(:each) do
    assign(:agent_finance_bill, Agent::FinanceBill.new())
  end
  it "renders new agent_finance_bill form" do
    render
    assert_select "form[action=?][method=?]", agent_finance_bills_path, "post" do
    end
  end
end
