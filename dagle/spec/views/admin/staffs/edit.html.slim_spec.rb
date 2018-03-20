require 'rails_helper'

RSpec.describe "admin/staffs/edit", type: :view do
  before(:each) do
    @staff = assign(:staff, Staff.create!(id: 1, ))
  end
  it "renders the edit admin_staff form" do
    render
    assert_select "form[action=?][method=?]", admin_staff_path(@staff), "post" do
    end
  end
end
