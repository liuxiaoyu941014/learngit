require 'rails_helper'

RSpec.describe "admin/finance_bills/show", type: :view do
  before(:each) do
    @finance_bill = assign(:finance_bill, FinanceBill.new(id: 1,
      :code => "Code",
      :amount => 2,
      :site_id => 3,
      :status => 4
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
