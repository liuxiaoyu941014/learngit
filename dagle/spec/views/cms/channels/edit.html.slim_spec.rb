require 'rails_helper'

RSpec.describe "cms/channels/edit", type: :view do
  before(:each) do
    @cms_channel = assign(:cms_channel, Cms::Channel.create!(
      :site => nil,
      :parent_id => 1,
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
  it "renders the edit cms_channel form" do
    render
    assert_select "form[action=?][method=?]", cms_channel_path(@cms_channel), "post" do

      assert_select "input#cms_channel_site_id[name=?]", "cms_channel[site_id]"

      assert_select "input#cms_channel_parent_id[name=?]", "cms_channel[parent_id]"

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
