require 'rails_helper'

RSpec.describe "admin/cms/show", type: :view do
  before(:each) do
    @cms_channel = assign(:cms_channel, Cms::Channel.new(id: 1,
      :site => nil,
      :channel => nil,
      :title => "Title",
      :short_title => "Short Title",
      :properties => "Properties",
      :tmp_index => "Tmp Index",
      :tmp_detail => "Tmp Detail",
      :keywords => "Keywords",
      :description => "Description",
      :image_path => "Image Path",
      :content => "MyText"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Short Title/)
    expect(rendered).to match(/Properties/)
    expect(rendered).to match(/Tmp Index/)
    expect(rendered).to match(/Tmp Detail/)
    expect(rendered).to match(/Keywords/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Image Path/)
    expect(rendered).to match(/MyText/)
  end
end
