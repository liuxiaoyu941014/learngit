require 'rails_helper'

RSpec.describe "admin/finance_histories/index", type: :view do
  before(:each) do
    assign(:finance_histories, [
      FinanceHistory.new(id: 1,
        :operate_type => 2,
        :amount => "9.99",
        :note => "Note"
      ),
      FinanceHistory.new(id: 2,
        :operate_type => 2,
        :amount => "9.99",
        :note => "Note"
      )
    ])
  end
  it "renders a list of admin/finance_histories" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end
