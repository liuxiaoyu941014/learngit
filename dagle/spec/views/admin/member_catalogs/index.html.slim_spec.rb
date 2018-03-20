require 'rails_helper'

RSpec.describe "admin/member_catalogs/index", type: :view do
  before(:each) do
    assign(:member_catalogs, [
      MemberCatalog.new(id: 1,
        :key => "Key",
        :value => "Value"
      ),
      MemberCatalog.new(id: 2,
        :key => "Key",
        :value => "Value"
      )
    ])
  end
  it "renders a list of admin/member_catalogs" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
