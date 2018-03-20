require 'rails_helper'

RSpec.describe "admin/material_managements/new", type: :view do
  before(:each) do
    assign(:material_management, MaterialManagement.new(
      :operate_date => "MyString",
      :note => "MyString"
    ))
  end
  it "renders new admin_material_management form" do
    render
    assert_select "form[action=?][method=?]", admin_material_managements_path, "post" do

      assert_select "input#material_management_operate_date[name=?]", "material_management[operate_date]"

      assert_select "input#material_management_note[name=?]", "material_management[note]"
    end
  end
end
