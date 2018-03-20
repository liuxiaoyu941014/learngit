require 'rails_helper'

RSpec.describe "agent/finance_bills/show", type: :view do
  before(:each) do
    @agent_finance_bill = assign(:agent_finance_bill, Agent::FinanceBill.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
