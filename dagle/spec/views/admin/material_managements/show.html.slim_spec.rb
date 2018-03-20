require 'rails_helper'

RSpec.describe "admin/material_managements/show", type: :view do
  before(:each) do
    @material_management = assign(:material_management, MaterialManagement.new(id: 1,
      :operate_date => "Operate Date",
      :note => "Note"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Operate Date/)
    expect(rendered).to match(/Note/)
  end
end
