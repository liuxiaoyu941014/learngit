require 'rails_helper'

RSpec.describe "admin/communities/show", type: :view do
  before(:each) do
    @community = assign(:community, Community.new(id: 1,
      :name => "Name",
      :address_line => "Address Line"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address Line/)
  end
end
