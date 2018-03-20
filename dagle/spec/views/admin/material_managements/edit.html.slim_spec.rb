require 'rails_helper'

RSpec.describe "admin/material_managements/edit", type: :view do
  before(:each) do
    @material_management = assign(:material_management, MaterialManagement.create!(id: 1, 
      :operate_date => "MyString",
      :note => "MyString"
    ))
  end
  it "renders the edit admin_material_management form" do
    render
    assert_select "form[action=?][method=?]", admin_material_management_path(@material_management), "post" do

      assert_select "input#material_management_operate_date[name=?]", "material_management[operate_date]"

      assert_select "input#material_management_note[name=?]", "material_management[note]"
    end
  end
end
