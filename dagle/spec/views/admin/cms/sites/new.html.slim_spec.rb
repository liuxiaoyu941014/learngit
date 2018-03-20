require 'rails_helper'

RSpec.describe "admin/cms/new", type: :view do
  before(:each) do
    assign(:cms_site, Cms::Site.new(
      :site => nil,
      :name => "MyString",
      :template => "MyString",
      :domain => "MyString",
      :description => "MyString",
      :features => "",
      :is_published => false
    ))
  end
  it "renders new admin_cm form" do
    render
    assert_select "form[action=?][method=?]", admin_cms_sites_path, "post" do

      assert_select "input#cms_site_site_id[name=?]", "cms_site[site_id]"

      assert_select "input#cms_site_name[name=?]", "cms_site[name]"

      assert_select "input#cms_site_template[name=?]", "cms_site[template]"

      assert_select "input#cms_site_domain[name=?]", "cms_site[domain]"

      assert_select "input#cms_site_description[name=?]", "cms_site[description]"

      assert_select "input#cms_site_features[name=?]", "cms_site[features]"

      assert_select "input#cms_site_is_published[name=?]", "cms_site[is_published]"
    end
  end
end
