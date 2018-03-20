require 'rails_helper'

RSpec.describe "admin/finance_bills/index", type: :view do
  before(:each) do
    assign(:finance_bills, [
      FinanceBill.new(id: 1,
        :code => "Code",
        :amount => 2,
        :site_id => 3,
        :status => 4
      ),
      FinanceBill.new(id: 2,
        :code => "Code",
        :amount => 2,
        :site_id => 3,
        :status => 4
      )
    ])
  end
  it "renders a list of admin/finance_bills" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
