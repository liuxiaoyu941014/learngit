require 'rails_helper'

RSpec.describe "admin/cms/show", type: :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, Cms::Comment.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
