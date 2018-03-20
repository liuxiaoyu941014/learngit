require 'rails_helper'

RSpec.describe "agent/sites/index", type: :view do
  before(:each) do
    assign(:sites, [
      Site.new(id: 1,
        :user => nil,
        :title => "Title"
      ),
      Site.new(id: 2,
        :user => nil,
        :title => "Title"
      )
    ])
  end
  it "renders a list of agent/sites" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
