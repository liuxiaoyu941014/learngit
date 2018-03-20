require 'rails_helper'

RSpec.describe "admin/forages/show", type: :view do
  before(:each) do
    @forage_simple = assign(:forage_simple, Forage::Simple.new(id: 1,
      :forage_run_key => nil,
      :catalog => "Catalog",
      :title => "Title",
      :url => "Url"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Catalog/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Url/)
  end
end
