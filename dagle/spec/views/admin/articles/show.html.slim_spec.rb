require 'rails_helper'

RSpec.describe "admin/articles/show", type: :view do
  before(:each) do
    @article = assign(:article, Article.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
