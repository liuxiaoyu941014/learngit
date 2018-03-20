require 'rails_helper'

RSpec.describe "admin/sites/new", type: :view do
  before(:each) do
    assign(:site, Site.new(
      :user => nil,
      :title => "MyString",
      :description => "MyString"
    ))
  end
  it "renders new admin_site form" do
    render
    assert_select "form[action=?][method=?]", admin_sites_path, "post" do

      assert_select "select#site_user_id[name=?]", "site[user_id]"

      assert_select "input#site_title[name=?]", "site[title]"

      assert_select "input#site_description[name=?]", "site[description]"
    end
  end
end
