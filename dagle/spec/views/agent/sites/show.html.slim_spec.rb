require 'rails_helper'

RSpec.describe "agent/sites/show", type: :view do
  before(:each) do
    @site = assign(:site, Site.new(id: 1,
      :user => nil,
      :title => "Title"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
  end
end
