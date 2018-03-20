require 'rails_helper'

RSpec.describe "agent/finance_bills/edit", type: :view do
  before(:each) do
    @agent_finance_bill = assign(:agent_finance_bill, Agent::FinanceBill.create!(id: 1, ))
  end
  it "renders the edit agent_finance_bill form" do
    render
    assert_select "form[action=?][method=?]", agent_finance_bill_path(@agent_finance_bill), "post" do
    end
  end
end
