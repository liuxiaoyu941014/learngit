require 'rails_helper'

RSpec.describe "cms/keystores/show", type: :view do
  before(:each) do
    @cms_keystore = assign(:cms_keystore, Cms::Keystore.new(id: 1,
      :site => nil,
      :key => "Key",
      :value => "Value",
      :description => "Description"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(/Description/)
  end
end
