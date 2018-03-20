require 'rails_helper'

RSpec.describe "admin/app_banners/show", type: :view do
  before(:each) do
    @admin_app_banner = assign(:admin_app_banner, Admin::AppBanner.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
