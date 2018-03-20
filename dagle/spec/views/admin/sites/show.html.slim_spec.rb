require 'rails_helper'

RSpec.describe "admin/sites/show", type: :view do
  before(:each) do
    @site = assign(:site, Site.new(id: 1,
      :user => create(:user),
      :title => "Title",
      :description => "Description"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
  end
end
