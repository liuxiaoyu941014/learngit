require 'rails_helper'

RSpec.describe "admin/market_templates/new", type: :view do
  before(:each) do
    assign(:market_template, MarketTemplate.new())
  end
  it "renders new admin_market_template form" do
    render
    assert_select "form[action=?][method=?]", admin_market_templates_path, "post" do
    end
  end
end
