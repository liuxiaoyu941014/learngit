require 'rails_helper'

RSpec.describe "admin/materials/new", type: :view do
  before(:each) do
    assign(:material, Material.new(
      :name => "MyString",
      :name_py => "MyString"
    ))
  end
  it "renders new admin_material form" do
    render
    assert_select "form[action=?][method=?]", admin_materials_path, "post" do

      assert_select "input#material_name[name=?]", "material[name]"

      assert_select "input#material_name_py[name=?]", "material[name_py]"
    end
  end
end
