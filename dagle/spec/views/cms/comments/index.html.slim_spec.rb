require 'rails_helper'

RSpec.describe "cms/comments/index", type: :view do
  before(:each) do
    assign(:cms_comments, [
      Cms::Comment.new(id: 1,
        :contact => "Contact",
        :content => "MyText",
        :features => ""
      ),
      Cms::Comment.new(id: 2,
        :contact => "Contact",
        :content => "MyText",
        :features => ""
      )
    ])
  end
  it "renders a list of cms/comments" do
    render
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
