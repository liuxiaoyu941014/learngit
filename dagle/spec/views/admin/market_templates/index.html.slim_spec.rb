require 'rails_helper'

RSpec.describe "admin/market_templates/index", type: :view do
  before(:each) do
    assign(:market_templates, [
      MarketTemplate.new(id: 1,),
      MarketTemplate.new(id: 2,)
    ])
  end
  it "renders a list of admin/market_templates" do
    render
  end
end
