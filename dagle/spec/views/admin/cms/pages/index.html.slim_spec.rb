require 'rails_helper'

RSpec.describe "admin/cms/index", type: :view do
  before(:each) do
    assign(:cms_pages, [
      Cms::Page.new(id: 1,
        :channel => nil,
        :title => "Title",
        :short_title => "Short Title",
        :properties => "Properties",
        :keywords => "Keywords",
        :description => "Description",
        :image_path => "Image Path",
        :content => "MyText"
      ),
      Cms::Page.new(id: 2,
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
  it "renders a list of admin/cms" do
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
