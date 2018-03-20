require 'rails_helper'

RSpec.describe "cms/sites/index", type: :view do
  before(:each) do
    assign(:cms_sites, [
      Cms::Site.create!(
        :name => "Name",
        :template => "Template",
        :domain => "Domain",
        :description => "Description",
        :is_published => false
      ),
      Cms::Site.create!(
        :name => "Name",
        :template => "Template",
        :domain => "Domain",
        :description => "Description",
        :is_published => false
      )
    ])
  end
  it "renders a list of cms/sites" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Template".to_s, :count => 2
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
