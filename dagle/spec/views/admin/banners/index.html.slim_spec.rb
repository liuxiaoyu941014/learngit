require 'rails_helper'

RSpec.describe "admin/banners/index", type: :view do
  before(:each) do
    assign(:banners, [
      Banner.new(id: 1,),
      Banner.new(id: 2,)
    ])
  end
  it "renders a list of admin/banners" do
    render
  end
end
