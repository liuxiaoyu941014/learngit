require 'rails_helper'

RSpec.describe "admin/cms/index", type: :view do
  before(:each) do
    assign(:cms_comments, [
      Cms::Comment.new(id: 1,),
      Cms::Comment.new(id: 2,)
    ])
  end
  it "renders a list of admin/cms" do
    render
  end
end
