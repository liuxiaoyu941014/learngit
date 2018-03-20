require 'rails_helper'

RSpec.describe "admin/finance_bills/edit", type: :view do
  before(:each) do
    @finance_bill = assign(:finance_bill, FinanceBill.create!(id: 1, 
      :code => "MyString",
      :amount => 1,
      :site_id => 1,
      :status => 1
    ))
  end
  it "renders the edit admin_finance_bill form" do
    render
    assert_select "form[action=?][method=?]", admin_finance_bill_path(@finance_bill), "post" do

      assert_select "input#finance_bill_code[name=?]", "finance_bill[code]"

      assert_select "input#finance_bill_amount[name=?]", "finance_bill[amount]"

      assert_select "input#finance_bill_site_id[name=?]", "finance_bill[site_id]"

      assert_select "input#finance_bill_status[name=?]", "finance_bill[status]"
    end
  end
end
