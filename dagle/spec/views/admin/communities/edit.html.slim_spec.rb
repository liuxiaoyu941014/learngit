require 'rails_helper'

RSpec.describe "admin/communities/edit", type: :view do
  before(:each) do
    @community = assign(:community, Community.create!(id: 1, 
      :name => "MyString",
      :address_line => "MyString"
    ))
  end
  it "renders the edit admin_community form" do
    render
    assert_select "form[action=?][method=?]", admin_community_path(@community), "post" do

      assert_select "input#community_name[name=?]", "community[name]"

      assert_select "input#community_address_line[name=?]", "community[address_line]"
    end
  end
end
