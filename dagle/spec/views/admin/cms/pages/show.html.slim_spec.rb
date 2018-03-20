require 'rails_helper'

RSpec.describe "admin/cms/show", type: :view do
  before(:each) do
    @cms_page = assign(:cms_page, Cms::Page.new(id: 1,
      :channel => nil,
      :title => "Title",
      :short_title => "Short Title",
      :properties => "Properties",
      :keywords => "Keywords",
      :description => "Description",
      :image_path => "Image Path",
      :content => "MyText"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Short Title/)
    expect(rendered).to match(/Properties/)
    expect(rendered).to match(/Keywords/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Image Path/)
    expect(rendered).to match(/MyText/)
  end
end
