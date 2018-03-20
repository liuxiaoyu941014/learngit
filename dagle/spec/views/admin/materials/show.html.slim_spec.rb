require 'rails_helper'

RSpec.describe "admin/materials/show", type: :view do
  before(:each) do
    @material = assign(:material, Material.new(id: 1,
      :name => "Name",
      :name_py => "Name Py"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Name Py/)
  end
end
