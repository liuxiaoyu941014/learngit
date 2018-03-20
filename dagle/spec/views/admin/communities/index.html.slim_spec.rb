require 'rails_helper'

RSpec.describe "admin/communities/index", type: :view do
  before(:each) do
    assign(:communities, [
      Community.new(id: 1,
        :name => "Name",
        :address_line => "Address Line"
      ),
      Community.new(id: 2,
        :name => "Name",
        :address_line => "Address Line"
      )
    ])
  end
  it "renders a list of admin/communities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line".to_s, :count => 2
  end
end
