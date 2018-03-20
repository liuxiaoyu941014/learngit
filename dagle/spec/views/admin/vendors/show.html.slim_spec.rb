require 'rails_helper'

RSpec.describe "admin/vendors/show", type: :view do
  before(:each) do
    @vendor = assign(:vendor, Vendor.new(id: 1,
      :name => "Name",
      :contact_name => "Contact Name",
      :phone_number => "Phone Number",
      :description => "Description"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Contact Name/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Description/)
  end
end
