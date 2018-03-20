require 'rails_helper'

RSpec.describe "cms/channels/index", type: :view do
  before(:each) do
    assign(:cms_channels, [
      Cms::Channel.create!(
        :site => nil,
        :parent_id => 2,
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
      Cms::Channel.create!(
        :site => nil,
        :parent_id => 2,
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
  it "renders a list of cms/channels" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
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
