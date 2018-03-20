require 'rails_helper'

RSpec.describe "admin/cms/show", type: :view do
  before(:each) do
    @cms_site = assign(:cms_site, Cms::Site.new(id: 1,
      :site => nil,
      :name => "Name",
      :template => "Template",
      :domain => "Domain",
      :description => "Description",
      :features => "",
      :is_published => false
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Template/)
    expect(rendered).to match(/Domain/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
