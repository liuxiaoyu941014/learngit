require 'rails_helper'

RSpec.describe "admin/staffs/show", type: :view do
  before(:each) do
    @staff = assign(:staff, Staff.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
