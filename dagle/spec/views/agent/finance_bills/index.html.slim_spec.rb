require 'rails_helper'

RSpec.describe "agent/finance_bills/index", type: :view do
  before(:each) do
    assign(:agent_finance_bills, [
      Agent::FinanceBill.new(id: 1,),
      Agent::FinanceBill.new(id: 2,)
    ])
  end
  it "renders a list of agent/finance_bills" do
    render
  end
end
