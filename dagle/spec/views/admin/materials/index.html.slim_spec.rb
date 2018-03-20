require 'rails_helper'

RSpec.describe "admin/materials/index", type: :view do
  before(:each) do
    assign(:materials, [
      Material.new(id: 1,
        :name => "Name",
        :name_py => "Name Py"
      ),
      Material.new(id: 2,
        :name => "Name",
        :name_py => "Name Py"
      )
    ])
  end
  it "renders a list of admin/materials" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Name Py".to_s, :count => 2
  end
end
