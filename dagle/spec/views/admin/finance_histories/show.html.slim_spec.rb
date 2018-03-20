require 'rails_helper'

RSpec.describe "admin/finance_histories/show", type: :view do
  before(:each) do
    @finance_history = assign(:finance_history, FinanceHistory.new(id: 1,
      :operate_type => 2,
      :amount => "9.99",
      :note => "Note"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Note/)
  end
end
