require 'rails_helper'

RSpec.describe "admin/catalogs/index", type: :view do
  before(:each) do
    assign(:admin_catalogs, [
      Catalog.create!(
        :parent => nil,
        :name => "Name",
        :position => 2
      ),
      Catalog.create!(
        :parent => nil,
        :name => "Name",
        :position => 2
      )
    ])
  end
  it "renders a list of admin/catalogs" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
