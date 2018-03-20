require 'rails_helper'

RSpec.describe "admin/catalogs/new", type: :view do
  before(:each) do
    assign(:admin_catalog, Catalog.new(
      :parent => nil,
      :name => "MyString",
      :position => 1
    ))
  end
  it "renders new admin_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_catalogs_path, "post" do

      assert_select "input#admin_catalog_parent_id[name=?]", "admin_catalog[parent_id]"

      assert_select "input#admin_catalog_name[name=?]", "admin_catalog[name]"

      assert_select "input#admin_catalog_position[name=?]", "admin_catalog[position]"
    end
  end
end
