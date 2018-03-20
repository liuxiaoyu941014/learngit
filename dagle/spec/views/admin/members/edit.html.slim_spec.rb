require 'rails_helper'

RSpec.describe "admin/members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(id: 1, ))
  end
  it "renders the edit admin_member form" do
    render
    assert_select "form[action=?][method=?]", admin_member_path(@member), "post" do
    end
  end
end
