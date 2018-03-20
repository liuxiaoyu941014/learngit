require 'rails_helper'

RSpec.describe "admin/banners/new", type: :view do
  before(:each) do
    assign(:banner, Banner.new())
  end
  it "renders new admin_banner form" do
    render
    assert_select "form[action=?][method=?]", admin_banners_path, "post" do
    end
  end
end
