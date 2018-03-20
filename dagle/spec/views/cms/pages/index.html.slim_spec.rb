require 'rails_helper'

RSpec.describe "cms/pages/index", type: :view do
  before(:each) do
    assign(:cms_pages, [
      Cms::Page.create!(
        :channel => nil,
        :title => "Title",
        :short_title => "Short Title",
        :properties => "Properties",
        :keywords => "Keywords",
        :description => "Description",
        :image_path => "Image Path",
        :content => "MyText"
      ),
      Cms::Page.create!(
        :channel => nil,
        :title => "Title",
        :short_title => "Short Title",
        :properties => "Properties",
        :keywords => "Keywords",
        :description => "Description",
        :image_path => "Image Path",
        :content => "MyText"
      )
    ])
  end
  it "renders a list of cms/pages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Short Title".to_s, :count => 2
    assert_select "tr>td", :text => "Properties".to_s, :count => 2
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Image Path".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
