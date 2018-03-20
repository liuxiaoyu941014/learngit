require 'rails_helper'

RSpec.describe "admin/banners/edit", type: :view do
  before(:each) do
    @banner = assign(:banner, Banner.create!(id: 1, ))
  end
  it "renders the edit admin_banner form" do
    render
    assert_select "form[action=?][method=?]", admin_banner_path(@banner), "post" do
    end
  end
end
