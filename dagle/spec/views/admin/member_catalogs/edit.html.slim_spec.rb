require 'rails_helper'

RSpec.describe "admin/member_catalogs/edit", type: :view do
  before(:each) do
    @member_catalog = assign(:member_catalog, MemberCatalog.create!(id: 1, 
      :key => "MyString",
      :value => "MyString"
    ))
  end
  it "renders the edit admin_member_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_member_catalog_path(@member_catalog), "post" do

      assert_select "input#member_catalog_key[name=?]", "member_catalog[key]"

      assert_select "input#member_catalog_value[name=?]", "member_catalog[value]"
    end
  end
end
