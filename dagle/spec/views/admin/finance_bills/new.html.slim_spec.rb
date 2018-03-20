require 'rails_helper'

RSpec.describe "admin/finance_bills/new", type: :view do
  before(:each) do
    assign(:finance_bill, FinanceBill.new(
      :code => "MyString",
      :amount => 1,
      :site_id => 1,
      :status => 1
    ))
  end
  it "renders new admin_finance_bill form" do
    render
    assert_select "form[action=?][method=?]", admin_finance_bills_path, "post" do

      assert_select "input#finance_bill_code[name=?]", "finance_bill[code]"

      assert_select "input#finance_bill_amount[name=?]", "finance_bill[amount]"

      assert_select "input#finance_bill_site_id[name=?]", "finance_bill[site_id]"

      assert_select "input#finance_bill_status[name=?]", "finance_bill[status]"
    end
  end
end
