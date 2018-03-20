require 'rails_helper'

RSpec.describe "admin/app_banners/edit", type: :view do
  before(:each) do
    @admin_app_banner = assign(:admin_app_banner, Admin::AppBanner.create!(id: 1, ))
  end
  it "renders the edit admin_app_banner form" do
    render
    assert_select "form[action=?][method=?]", admin_app_banner_path(@admin_app_banner), "post" do
    end
  end
end
