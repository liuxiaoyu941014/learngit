require 'rails_helper'

RSpec.describe "admin/vendors/new", type: :view do
  before(:each) do
    assign(:vendor, Vendor.new(
      :name => "MyString",
      :contact_name => "MyString",
      :phone_number => "MyString",
      :description => "MyString"
    ))
  end
  it "renders new admin_vendor form" do
    render
    assert_select "form[action=?][method=?]", admin_vendors_path, "post" do

      assert_select "input#vendor_name[name=?]", "vendor[name]"

      assert_select "input#vendor_contact_name[name=?]", "vendor[contact_name]"

      assert_select "input#vendor_phone_number[name=?]", "vendor[phone_number]"

      assert_select "input#vendor_description[name=?]", "vendor[description]"
    end
  end
end
