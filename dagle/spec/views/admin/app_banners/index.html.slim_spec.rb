require 'rails_helper'

RSpec.describe "admin/app_banners/index", type: :view do
  before(:each) do
    assign(:admin_app_banners, [
      Admin::AppBanner.new(id: 1,),
      Admin::AppBanner.new(id: 2,)
    ])
  end
  it "renders a list of admin/app_banners" do
    render
  end
end
