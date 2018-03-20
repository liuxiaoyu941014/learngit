require 'rails_helper'

RSpec.describe "admin/cms/new", type: :view do
  before(:each) do
    assign(:cms_comment, Cms::Comment.new())
  end
  it "renders new admin_cm form" do
    render
    assert_select "form[action=?][method=?]", admin_cms_comments_path, "post" do
    end
  end
end
