require 'rails_helper'

RSpec.describe "admin/app_banners/new", type: :view do
  before(:each) do
    assign(:admin_app_banner, Admin::AppBanner.new())
  end
  it "renders new admin_app_banner form" do
    render
    assert_select "form[action=?][method=?]", admin_app_banners_path, "post" do
    end
  end
end
