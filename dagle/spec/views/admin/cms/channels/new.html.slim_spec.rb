require 'rails_helper'

RSpec.describe "admin/cms/new", type: :view do
  before(:each) do
    assign(:cms_channel, Cms::Channel.new(
      :site => nil,
      :channel => nil,
      :title => "MyString",
      :short_title => "MyString",
      :properties => "MyString",
      :tmp_index => "MyString",
      :tmp_detail => "MyString",
      :keywords => "MyString",
      :description => "MyString",
      :image_path => "MyString",
      :content => "MyText"
    ))
  end
  it "renders new admin_cm form" do
    render
    assert_select "form[action=?][method=?]", admin_cms_channels_path, "post" do

      assert_select "input#cms_channel_site_id[name=?]", "cms_channel[site_id]"

      assert_select "input#cms_channel_channel_id[name=?]", "cms_channel[channel_id]"

      assert_select "input#cms_channel_title[name=?]", "cms_channel[title]"

      assert_select "input#cms_channel_short_title[name=?]", "cms_channel[short_title]"

      assert_select "input#cms_channel_properties[name=?]", "cms_channel[properties]"

      assert_select "input#cms_channel_tmp_index[name=?]", "cms_channel[tmp_index]"

      assert_select "input#cms_channel_tmp_detail[name=?]", "cms_channel[tmp_detail]"

      assert_select "input#cms_channel_keywords[name=?]", "cms_channel[keywords]"

      assert_select "input#cms_channel_description[name=?]", "cms_channel[description]"

      assert_select "input#cms_channel_image_path[name=?]", "cms_channel[image_path]"

      assert_select "textarea#cms_channel_content[name=?]", "cms_channel[content]"
    end
  end
end
