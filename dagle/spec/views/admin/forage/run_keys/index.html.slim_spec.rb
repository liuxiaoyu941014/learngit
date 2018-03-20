require 'rails_helper'

RSpec.describe "admin/forages/index", type: :view do
  before(:each) do
    assign(:forage_run_keys, [
      Forage::RunKey.new(id: 1,
        :source => nil,
        :date => "Date"
      ),
      Forage::RunKey.new(id: 2,
        :source => nil,
        :date => "Date"
      )
    ])
  end
  it "renders a list of admin/forages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
  end
end
