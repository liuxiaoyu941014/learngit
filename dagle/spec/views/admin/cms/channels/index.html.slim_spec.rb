require 'rails_helper'

RSpec.describe "admin/cms/index", type: :view do
  before(:each) do
    assign(:cms_channels, [
      Cms::Channel.new(id: 1,
        :site => nil,
        :channel => nil,
        :title => "Title",
        :short_title => "Short Title",
        :properties => "Properties",
        :tmp_index => "Tmp Index",
        :tmp_detail => "Tmp Detail",
        :keywords => "Keywords",
        :description => "Description",
        :image_path => "Image Path",
        :content => "MyText"
      ),
      Cms::Channel.new(id: 2,
        :site => nil,
        :channel => nil,
        :title => "Title",
        :short_title => "Short Title",
        :properties => "Properties",
        :tmp_index => "Tmp Index",
        :tmp_detail => "Tmp Detail",
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
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Short Title".to_s, :count => 2
    assert_select "tr>td", :text => "Properties".to_s, :count => 2
    assert_select "tr>td", :text => "Tmp Index".to_s, :count => 2
    assert_select "tr>td", :text => "Tmp Detail".to_s, :count => 2
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Image Path".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
