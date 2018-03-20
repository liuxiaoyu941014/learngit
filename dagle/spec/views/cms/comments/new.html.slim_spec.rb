require 'rails_helper'

RSpec.describe "cms/comments/new", type: :view do
  before(:each) do
    assign(:cms_comment, Cms::Comment.new(
      :contact => "MyString",
      :content => "MyText",
      :features => ""
    ))
  end
  it "renders new cms_comment form" do
    render
    assert_select "form[action=?][method=?]", cms_comments_path, "post" do

      assert_select "input#cms_comment_contact[name=?]", "cms_comment[contact]"

      assert_select "textarea#cms_comment_content[name=?]", "cms_comment[content]"

      assert_select "input#cms_comment_features[name=?]", "cms_comment[features]"
    end
  end
end
