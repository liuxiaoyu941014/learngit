require 'rails_helper'

RSpec.describe "cms/pages/edit", type: :view do
  before(:each) do
    @cms_page = assign(:cms_page, Cms::Page.create!(
      :channel => nil,
      :title => "MyString",
      :short_title => "MyString",
      :properties => "MyString",
      :keywords => "MyString",
      :description => "MyString",
      :image_path => "MyString",
      :content => "MyText"
    ))
  end
  it "renders the edit cms_page form" do
    render
    assert_select "form[action=?][method=?]", cms_page_path(@cms_page), "post" do

      assert_select "input#cms_page_channel_id[name=?]", "cms_page[channel_id]"

      assert_select "input#cms_page_title[name=?]", "cms_page[title]"

      assert_select "input#cms_page_short_title[name=?]", "cms_page[short_title]"

      assert_select "input#cms_page_properties[name=?]", "cms_page[properties]"

      assert_select "input#cms_page_keywords[name=?]", "cms_page[keywords]"

      assert_select "input#cms_page_description[name=?]", "cms_page[description]"

      assert_select "input#cms_page_image_path[name=?]", "cms_page[image_path]"

      assert_select "textarea#cms_page_content[name=?]", "cms_page[content]"
    end
  end
end
