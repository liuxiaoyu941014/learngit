require 'rails_helper'

RSpec.describe "admin/member_catalogs/new", type: :view do
  before(:each) do
    assign(:member_catalog, MemberCatalog.new(
      :key => "MyString",
      :value => "MyString"
    ))
  end
  it "renders new admin_member_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_member_catalogs_path, "post" do

      assert_select "input#member_catalog_key[name=?]", "member_catalog[key]"

      assert_select "input#member_catalog_value[name=?]", "member_catalog[value]"
    end
  end
end
