require 'rails_helper'

RSpec.describe "admin/finance_histories/edit", type: :view do
  before(:each) do
    @finance_history = assign(:finance_history, FinanceHistory.create!(id: 1, 
      :operate_type => 1,
      :amount => "9.99",
      :note => "MyString"
    ))
  end
  it "renders the edit admin_finance_history form" do
    render
    assert_select "form[action=?][method=?]", admin_finance_history_path(@finance_history), "post" do

      assert_select "input#finance_history_operate_type[name=?]", "finance_history[operate_type]"

      assert_select "input#finance_history_amount[name=?]", "finance_history[amount]"

      assert_select "input#finance_history_note[name=?]", "finance_history[note]"
    end
  end
end
