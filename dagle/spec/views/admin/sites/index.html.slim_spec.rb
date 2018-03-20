require 'rails_helper'

RSpec.describe "admin/sites/index", type: :view do
  before(:each) do
    assign(:sites, [
      Site.new(id: 1,
        :user => nil,
        :title => "Title",
        :description => "Description"
      ),
      Site.new(id: 2,
        :user => nil,
        :title => "Title",
        :description => "Description"
      )
    ])
  end
  it "renders a list of admin/sites" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
