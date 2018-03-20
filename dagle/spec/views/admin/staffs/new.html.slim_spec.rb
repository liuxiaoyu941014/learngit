require 'rails_helper'

RSpec.describe "admin/staffs/new", type: :view do
  before(:each) do
    assign(:staff, Staff.new())
  end
  it "renders new admin_staff form" do
    render
    assert_select "form[action=?][method=?]", admin_staffs_path, "post" do
    end
  end
end
