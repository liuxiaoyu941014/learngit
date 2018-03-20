require 'rails_helper'

RSpec.describe "admin/banners/show", type: :view do
  before(:each) do
    @banner = assign(:banner, Banner.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
