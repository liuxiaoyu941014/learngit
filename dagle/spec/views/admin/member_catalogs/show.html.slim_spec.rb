require 'rails_helper'

RSpec.describe "admin/member_catalogs/show", type: :view do
  before(:each) do
    @member_catalog = assign(:member_catalog, MemberCatalog.new(id: 1,
      :key => "Key",
      :value => "Value"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
  end
end
