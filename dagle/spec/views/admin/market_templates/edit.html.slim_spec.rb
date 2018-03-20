require 'rails_helper'

RSpec.describe "admin/market_templates/edit", type: :view do
  before(:each) do
    @market_template = assign(:market_template, MarketTemplate.create!(id: 1, ))
  end
  it "renders the edit admin_market_template form" do
    render
    assert_select "form[action=?][method=?]", admin_market_template_path(@market_template), "post" do
    end
  end
end
