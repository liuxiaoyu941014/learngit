require 'rails_helper'

RSpec.describe "cms/comments/edit", type: :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, Cms::Comment.create!(id: 1, 
      :contact => "MyString",
      :content => "MyText",
      :features => ""
    ))
  end
  it "renders the edit cms_comment form" do
    render
    assert_select "form[action=?][method=?]", cms_comment_path(@cms_comment), "post" do

      assert_select "input#cms_comment_contact[name=?]", "cms_comment[contact]"

      assert_select "textarea#cms_comment_content[name=?]", "cms_comment[content]"

      assert_select "input#cms_comment_features[name=?]", "cms_comment[features]"
    end
  end
end
