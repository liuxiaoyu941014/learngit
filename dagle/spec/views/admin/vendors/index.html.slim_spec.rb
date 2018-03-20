require 'rails_helper'

RSpec.describe "admin/vendors/index", type: :view do
  before(:each) do
    assign(:vendors, [
      Vendor.new(id: 1,
        :name => "Name",
        :contact_name => "Contact Name",
        :phone_number => "Phone Number",
        :description => "Description"
      ),
      Vendor.new(id: 2,
        :name => "Name",
        :contact_name => "Contact Name",
        :phone_number => "Phone Number",
        :description => "Description"
      )
    ])
  end
  it "renders a list of admin/vendors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
