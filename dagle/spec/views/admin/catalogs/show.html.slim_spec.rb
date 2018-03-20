require 'rails_helper'

RSpec.describe "admin/catalogs/show", type: :view do
  before(:each) do
    @admin_catalog = assign(:admin_catalog, Catalog.create!(
      :parent => nil,
      :name => "Name",
      :position => 2
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
