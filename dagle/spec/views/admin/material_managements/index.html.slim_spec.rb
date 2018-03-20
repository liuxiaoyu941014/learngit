require 'rails_helper'

RSpec.describe "admin/material_managements/index", type: :view do
  before(:each) do
    assign(:material_managements, [
      MaterialManagement.new(id: 1,
        :operate_date => "Operate Date",
        :note => "Note"
      ),
      MaterialManagement.new(id: 2,
        :operate_date => "Operate Date",
        :note => "Note"
      )
    ])
  end
  it "renders a list of admin/material_managements" do
    render
    assert_select "tr>td", :text => "Operate Date".to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end
