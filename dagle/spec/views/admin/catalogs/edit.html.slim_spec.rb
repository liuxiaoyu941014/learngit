require 'rails_helper'

RSpec.describe "admin/catalogs/edit", type: :view do
  before(:each) do
    @admin_catalog = assign(:admin_catalog, Catalog.create!(
      :parent => nil,
      :name => "MyString",
      :position => 1
    ))
  end
  it "renders the edit admin_catalog form" do
    render
    assert_select "form[action=?][method=?]", admin_catalog_path(@admin_catalog), "post" do

      assert_select "input#admin_catalog_parent_id[name=?]", "admin_catalog[parent_id]"

      assert_select "input#admin_catalog_name[name=?]", "admin_catalog[name]"

      assert_select "input#admin_catalog_position[name=?]", "admin_catalog[position]"
    end
  end
end
