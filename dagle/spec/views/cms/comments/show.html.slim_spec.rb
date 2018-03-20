require 'rails_helper'

RSpec.describe "cms/comments/show", type: :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, Cms::Comment.new(id: 1,
      :contact => "Contact",
      :content => "MyText",
      :features => ""
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
