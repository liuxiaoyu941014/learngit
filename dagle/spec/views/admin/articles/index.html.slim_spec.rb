require 'rails_helper'

RSpec.describe "admin/articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.new(id: 1,),
      Article.new(id: 2,)
    ])
  end
  it "renders a list of admin/articles" do
    render
  end
end
