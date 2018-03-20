require 'rails_helper'

RSpec.describe "cms/sites/edit", type: :view do
  before(:each) do
    @cms_site = assign(:cms_site, Cms::Site.create!(
      :name => "MyString",
      :template => "MyString",
      :domain => "MyString",
      :description => "MyString",
      :is_published => false
    ))
  end
  it "renders the edit cms_site form" do
    render
    assert_select "form[action=?][method=?]", cms_site_path(@cms_site), "post" do

      assert_select "input#cms_site_name[name=?]", "cms_site[name]"

      assert_select "input#cms_site_template[name=?]", "cms_site[template]"

      assert_select "input#cms_site_domain[name=?]", "cms_site[domain]"

      assert_select "input#cms_site_description[name=?]", "cms_site[description]"

      assert_select "input#cms_site_is_published[name=?]", "cms_site[is_published]"
    end
  end
end
