require 'rails_helper'

RSpec.describe "cms/sites/show", type: :view do
  before(:each) do
    @cms_site = assign(:cms_site, Cms::Site.create!(
      :name => "Name",
      :template => "Template",
      :domain => "Domain",
      :description => "Description",
      :is_published => false
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Template/)
    expect(rendered).to match(/Domain/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
  end
end
