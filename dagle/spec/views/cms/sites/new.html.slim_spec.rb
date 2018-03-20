require 'rails_helper'

RSpec.describe "cms/sites/new", type: :view do
  before(:each) do
    assign(:cms_site, Cms::Site.new(
      :name => "MyString",
      :template => "MyString",
      :domain => "MyString",
      :description => "MyString",
      :is_published => false
    ))
  end
  it "renders new cms_site form" do
    render
    assert_select "form[action=?][method=?]", cms_sites_path, "post" do

      assert_select "input#cms_site_name[name=?]", "cms_site[name]"

      assert_select "input#cms_site_template[name=?]", "cms_site[template]"

      assert_select "input#cms_site_domain[name=?]", "cms_site[domain]"

      assert_select "input#cms_site_description[name=?]", "cms_site[description]"

      assert_select "input#cms_site_is_published[name=?]", "cms_site[is_published]"
    end
  end
end
