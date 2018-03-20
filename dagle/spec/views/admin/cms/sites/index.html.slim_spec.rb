require 'rails_helper'

RSpec.describe "admin/cms/index", type: :view do
  before(:each) do
    assign(:cms_sites, [
      Cms::Site.new(id: 1,
        :site => nil,
        :name => "Name",
        :template => "Template",
        :domain => "Domain",
        :description => "Description",
        :features => "",
        :is_published => false
      ),
      Cms::Site.new(id: 2,
        :site => nil,
        :name => "Name",
        :template => "Template",
        :domain => "Domain",
        :description => "Description",
        :features => "",
        :is_published => false
      )
    ])
  end
  it "renders a list of admin/cms" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Template".to_s, :count => 2
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
