require 'rails_helper'

RSpec.describe "admin/material_management_histories/index", type: :view do
  before(:each) do
    assign(:admin_material_management_histories, [
      Admin::MaterialManagementHistory.new(id: 1,
        :index => "Index"
      ),
      Admin::MaterialManagementHistory.new(id: 2,
        :index => "Index"
      )
    ])
  end
  it "renders a list of admin/material_management_histories" do
    render
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
