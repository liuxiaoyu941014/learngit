require 'rails_helper'

RSpec.describe "admin/communities/new", type: :view do
  before(:each) do
    assign(:community, Community.new(
      :name => "MyString",
      :address_line => "MyString"
    ))
  end
  it "renders new admin_community form" do
    render
    assert_select "form[action=?][method=?]", admin_communities_path, "post" do

      assert_select "input#community_name[name=?]", "community[name]"

      assert_select "input#community_address_line[name=?]", "community[address_line]"
    end
  end
end
