require 'rails_helper'

RSpec.describe "admin/materials/edit", type: :view do
  before(:each) do
    @material = assign(:material, Material.create!(id: 1, 
      :name => "MyString",
      :name_py => "MyString"
    ))
  end
  it "renders the edit admin_material form" do
    render
    assert_select "form[action=?][method=?]", admin_material_path(@material), "post" do

      assert_select "input#material_name[name=?]", "material[name]"

      assert_select "input#material_name_py[name=?]", "material[name_py]"
    end
  end
end
